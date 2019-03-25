import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/products_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class ProductListScreen extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  ProductListScreen(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(documentSnapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("products")
              .document(documentSnapshot.documentID)
              .collection("items")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return TabBarView(
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProductData productData = ProductData.fromDocument(snapshot.data.documents[index]);
                      productData.category = documentSnapshot.documentID;

                      return ProductTile("grid", productData);
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProductData productData = ProductData.fromDocument(snapshot.data.documents[index]);
                      productData.category = documentSnapshot.documentID;
                      return ProductTile("list", productData);
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
