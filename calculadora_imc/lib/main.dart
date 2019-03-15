import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _imcResult;

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _imcResult = null;
    });
  }

  void calculateImc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6) {
        _imcResult = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      } else if (imc > 40) {
        _imcResult = "Acima do peso (${imc.toStringAsPrecision(2)})";
      } else {
        _imcResult = "Está no peso ideal  (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120, color: Colors.green),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu peso";
                        }
                      },
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 22),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura";
                        }
                      },
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 22),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            height: 55,
                            child: RaisedButton(
                                child: Text("Calcular",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                color: Colors.green,
                                elevation: 5,
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    calculateImc();
                                  }
                                }))),
                    Text(
                      _imcResult ?? "Insira os dados para obter o resultado",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    )
                  ],
                ))));
  }
}
