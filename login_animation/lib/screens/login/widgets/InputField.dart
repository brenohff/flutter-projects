import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData leading;
  final String hint;
  final bool obscure;

  InputField({this.leading, this.hint, this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 0.5,
          ),
        ),
      ),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            leading,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          contentPadding:
              EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 5),
        ),
      ),
    );
  }
}
