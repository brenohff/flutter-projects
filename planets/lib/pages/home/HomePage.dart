import 'package:flutter/material.dart';
import 'package:planets/pages/home/HomePageBody.dart';
import 'package:planets/widgets/GradientAppBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppBar("Treva"),
          HomePageBody(),
        ],
      ),
    );
  }
}
