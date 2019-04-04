import 'package:all_of_block/widgets/HomeBloc.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Bloc"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: homeBloc.decrement,
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: homeBloc.outCount,
          builder: (context, AsyncSnapshot<int> snapshot) {
            return Text("Contagem em ${snapshot.data}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeBloc.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
