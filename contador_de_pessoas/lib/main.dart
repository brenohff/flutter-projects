import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador de Pessoas", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _quantPessoas = 0;
  String infoText = "Pode entrar!";

  void _changePeople(int delta){
    setState(() {
      if(_quantPessoas == 0 && delta == -1){
        infoText = "Não pode mais sair ninguem";
      }else if(_quantPessoas == 5 && delta == 1){
        infoText = "Não pode mais entrar ngm";
      }else{
        infoText = "Pode entrar!";
        _quantPessoas += delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/artusi-ristorante.jpg",
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_quantPessoas",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: FlatButton(
                      child: Text("+1",
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                      onPressed: () {
                        _changePeople(1);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: FlatButton(
                      child: Text("-1",
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                      onPressed: () {
                        _changePeople(-1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "$infoText",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30),
            )
          ],
        ),
      ],
    );
  }
}
