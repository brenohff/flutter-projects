import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home_page.dart';

void main() => runApp(MaterialApp(
      title: "Loja Virtual",
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(255, 4, 125, 141)),
      debugShowCheckedModeBanner: false,
    ));
