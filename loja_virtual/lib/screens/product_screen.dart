import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/model/cart_model.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData _productData;

  ProductScreen(this._productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(_productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData _product;
  String selectedSize;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: _product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 5,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: _primaryColor,
              autoplayDuration: Duration(seconds: 3),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$${_product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 35,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.515),
                    children: _product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              width: 2.5,
                              color: size == selectedSize
                                  ? _primaryColor
                                  : Colors.grey[500],
                            ),
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: selectedSize != null
                        ? () {
                            CartProduct cartProduct = CartProduct();
                            cartProduct.size = selectedSize;
                            cartProduct.quantity = 1;
                            cartProduct.idProduct = _product.id;
                            cartProduct.category = _product.category;

                            if (UserModel.of(context).isLoggedIn()) {
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para comprar!",
                      style: TextStyle(fontSize: 18),
                    ),
                    color: _primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  _product.description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}