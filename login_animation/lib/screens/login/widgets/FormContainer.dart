import 'package:flutter/material.dart';
import 'package:login_animation/screens/login/widgets/InputField.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: <Widget>[
            InputField(
              hint: "Username",
              leading: Icons.person_outline,
              obscure: false,
            ),
            InputField(
              hint: "Password",
              leading: Icons.lock_outline,
              obscure: true,
            ),
          ],
        ),
      ),
    );
  }
}
