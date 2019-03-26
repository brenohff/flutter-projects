import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  List<CartProduct> productsList = [];
  bool isLoading = false;
  String couponCode;
  int discountPercentage = 0;

  CartModel(this.userModel) {
    if (userModel.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    productsList.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((product) {
      cartProduct.idCart = product.documentID;
    }).catchError((error) {});

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .delete();

    productsList.remove(cartProduct);
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.idCart)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0;
    for (CartProduct c in productsList) {
      if (c.productData != null) {
        price += c.quantity * c.productData.price;
      }
    }

    return price;
  }

  double getDiscount() {
    return getProductsPrice() * (discountPercentage / 100);
  }

  double getShipPrice() {
    return 9.99;
  }

  void _loadCartItems() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    productsList = querySnapshot.documents
        .map((doc) => CartProduct.fromDocument(doc))
        .toList();
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (productsList.isEmpty) {
      return null;
    } else {
      isLoading = true;
      notifyListeners();

      double productsPrice = getProductsPrice();
      double discountPrice = getDiscount();
      double shipPrice = getShipPrice();

      DocumentReference ref =
          await Firestore.instance.collection("orders").add({
        "clientId": userModel.firebaseUser.uid,
        "products":
            productsList.map((cartProduct) => cartProduct.toMap()).toList(),
        "productsPrice": productsPrice,
        "discountPrice": discountPrice,
        "shipPrice": shipPrice,
        "totalPrice": (productsPrice + shipPrice - discountPrice),
        "status": 1
      });

      await Firestore.instance
          .collection("users")
          .document(userModel.firebaseUser.uid)
          .collection("orders")
          .document(ref.documentID)
          .setData({"orderId": ref.documentID});

      QuerySnapshot query = await Firestore.instance
          .collection("users")
          .document(userModel.firebaseUser.uid)
          .collection("cart")
          .getDocuments();

      for (DocumentSnapshot doc in query.documents) {
        doc.reference.delete();
      }

      productsList.clear();
      discountPrice = 0;
      couponCode = null;

      isLoading = false;
      notifyListeners();

      return ref.documentID;
    }
  }
}
