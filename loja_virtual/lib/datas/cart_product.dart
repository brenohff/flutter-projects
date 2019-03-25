import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/products_data.dart';

class CartProduct {
  String idCart;
  String category;
  String idProduct;
  String size;
  int quantity;
  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    idCart = documentSnapshot.documentID;
    category = documentSnapshot["category"];
    idProduct = documentSnapshot["idProduct"];
    size = documentSnapshot["size"];
    quantity = documentSnapshot["quantity"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "idProduct": idProduct,
      "size": size,
      "quantity": quantity,
//      "productData": productData.toResumedMap()
    };
  }
}
