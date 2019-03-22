import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
//          future: Firestore.instance.collection("products"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(color: Colors.red),
                  Container(color: Colors.green)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
