import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _toDoController = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic> _lastRemoved = Map();
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      newToDo["ok"] = false;
      _toDoList.add(newToDo);

      _toDoController.text = "";
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                            controller: _toDoController,
                            decoration: InputDecoration(
                                labelText: "Nova Tarefa",
                                labelStyle:
                                    TextStyle(color: Colors.blueAccent)))),
                    RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("ADD"),
                      textColor: Colors.white,
                      onPressed: _addToDo,
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: RefreshIndicator(
                  child: ListView.builder(
                      itemCount: _toDoList.length,
                      padding: EdgeInsets.only(top: 10),
                      itemBuilder: buildItem),
                  onRefresh: _refresh)),
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(index.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
          title: Text(_toDoList[index]["title"]),
          value: _toDoList[index]["ok"],
          secondary: CircleAvatar(
            child: Icon(
                _toDoList[index]["ok"] ? Icons.check : Icons.error_outline),
          ),
          onChanged: (hasChecked) {
            setState(() {
              _toDoList[index]["ok"] = hasChecked;
              _saveData();
            });
          }),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                },
                label: "Desfazer"),
            duration: Duration(seconds: 2),
          );

          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((firstItem, secondItem) {
        if (firstItem["ok"] && !secondItem["ok"]) {
          return 1;
        } else if (!firstItem["ok"] && secondItem["ok"]) {
          return -1;
        } else {
          return 0;
        }
      });

      return null;
    });
  }
}
