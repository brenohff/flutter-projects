import 'package:flutter/material.dart';
import 'package:planets/pages/home/HomePage.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Planets",
      home: new HomePage(),
//      routes: <String, WidgetBuilder>{'/detail': (context) => DetailPage(Planet())},
    ),
  );
}
