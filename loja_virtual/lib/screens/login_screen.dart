import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja_virtual/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(30),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) {
                        return "E-mail inválido!";
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6) {
                        return "Senha inválida!";
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          model.recoverPass();
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                        )),
                  ),
                  SizedBox(height: 55),
                  SizedBox(
                    height: 55,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSucess: _onSucess,
                              onFail: _onFail);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 55),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Não tem conta?"),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _onSucess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Não foi possível realizar login"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }
}
