import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:loja_virtual/model/cart_model.dart';

class CartProductTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartProductTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? getProductsData()
          : _buildContent(context),
    );
  }

  FutureBuilder<DocumentSnapshot> getProductsData() {
    return FutureBuilder<DocumentSnapshot>(
      future: Firestore.instance
          .collection("products")
          .document(cartProduct.category)
          .collection("items")
          .document(cartProduct.idProduct)
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          cartProduct.productData = ProductData.fromDocument(snapshot.data);
          return _buildContent(context);
        } else {
          return Container(
            height: 70,
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          );
        }
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          width: 120,
          child: Image.network(cartProduct.productData.images[0],
              fit: BoxFit.cover),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(cartProduct.productData.title,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                Text("Tamanho: ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300)),
                Text("R\$: ${cartProduct.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: cartProduct.quantity > 1 ? () {
                        CartModel.of(context).decProduct(cartProduct);
                      } : null,
                      icon: Icon(Icons.remove,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(cartProduct.quantity.toString()),
                    IconButton(
                      onPressed: () {CartModel.of(context).incProduct(cartProduct);},
                      icon: Icon(Icons.add,
                          color: Theme.of(context).primaryColor),
                    ),
                    FlatButton(
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                      child: Text("Remover",
                          style: TextStyle(
                            color: Colors.grey[500],
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
