import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_loja/blocs/login_bloc.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.outLoginState.listen((state) {
      switch (state) {
        case LoginState.IDLE:
        case LoginState.LOADING:
          break;
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro ao fazer login!"),
                    content:
                        Text("Você não possui os privilegios necessários :("),
                  ));
          break;
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outLoginState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          print(snapshot.data);
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
              );
              break;
            case LoginState.SUCCESS:
            case LoginState.FAIL:
            case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.store_mall_directory,
                            color: Colors.pinkAccent,
                            size: 160,
                          ),
                          _buildWidgets(Icons.person_outline, "Usuário", false,
                              _loginBloc.outEmail, _loginBloc.changeEmail),
                          _buildWidgets(Icons.lock_outline, "Senha", true,
                              _loginBloc.outPassword, _loginBloc.changePassw),
                          SizedBox(height: 32),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: StreamBuilder<bool>(
                              stream: _loginBloc.outSubmitValid,
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  disabledColor:
                                      Colors.pinkAccent.withAlpha(140),
                                  color: Colors.pinkAccent,
                                  child: Text("Entrar"),
                                  textColor: Colors.white,
                                  onPressed: snapshot.hasData
                                      ? _loginBloc.submit
                                      : null,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildWidgets(IconData icon, String text, bool isObscure,
      Stream<String> stream, Function(String) onChanged) {
    return StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            obscureText: isObscure,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent),
              ),
              contentPadding: EdgeInsets.only(
                left: 5,
                right: 30,
                top: 30,
                bottom: 30,
              ),
              errorText: snapshot.hasError ? snapshot.error : "",
            ),
            style: TextStyle(color: Colors.white),
          );
        });
  }
}
