import 'dart:io';

import 'package:agenda/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  Contact _editedContact;
  bool _userEdited = false;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
              _editedContact.name != null
                  ? _editedContact.name
                  : "Novo Contato",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editedContact.name != null &&
                  _editedContact.name.isNotEmpty) {
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            elevation: 5,
            backgroundColor: Colors.red,
            child: Icon(Icons.save)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact.image != null
                          ? FileImage(File(_editedContact.image))
                          : AssetImage("images/person.png"),
                    ),
                  ),
                ),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.gallery)
                      .then((file) {
                    if (file == null) {
                      return;
                    } else {
                      setState(() {
                        _editedContact.image = file.path;
                      });
                    }
                  });
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    onChanged: (text) {
                      _userEdited = true;

                      setState(() {
                        _editedContact.name = text;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nome"),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onChanged: (text) {
                      _userEdited = true;

                      setState(() {
                        _editedContact.email = text;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: _phoneController,
                    onChanged: (text) {
                      _userEdited = true;

                      setState(() {
                        _editedContact.phone = text;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Telefone"),
                    keyboardType: TextInputType.phone,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se sair, as alterações serão perdidas!!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pop(); // Tem que dar o pop 2x para poder sair do dialog e da pagina de contatos;
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
