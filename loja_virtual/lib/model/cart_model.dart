import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  List<CartProduct> productsList = [];

  CartModel(this.userModel);

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

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
}
