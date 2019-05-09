import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Teste $index"),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
