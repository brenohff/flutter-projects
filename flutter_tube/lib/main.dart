import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/VideosBloc.dart';
import 'package:flutter_tube/screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        title: 'Flutter Tube',
        home: HomeScreen(),
      ),
    );
  }
}
