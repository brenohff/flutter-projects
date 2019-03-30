import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rxdart_bloc/details/DetailsWidget.dart';
import 'package:flutter_rxdart_bloc/home/HomeBloc.dart';
import 'package:flutter_rxdart_bloc/models/SearchItem.dart';
import 'package:flutter_rxdart_bloc/models/SearchResult.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    homeBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GitHub Search"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            _textField(),
            StreamBuilder(
              stream: homeBloc.listItems,
              builder: (context, AsyncSnapshot<SearchResult> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.itemsList.length,
                        itemBuilder: (context, index) {
                          return _items(snapshot?.data?.itemsList[index]);
                        })
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return TextField(
      onChanged: homeBloc.searchEvent.add,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "flutter...",
          labelText: "Pesquisa"),
    );
  }

  Widget _items(SearchItem item) {
    return ListTile(
        title: Text(item?.fullName ?? "title"),
        subtitle: Text(item?.url ?? "url"),
        leading: Hero(
          tag: item.url,
          child: CircleAvatar(
            backgroundImage: NetworkImage(item?.avatarUrl ??
                "https://www.pngarts.com/files/3/Avatar-PNG-Download-Image.png"),
          ),
        ),
        onTap: () => Navigator.push(context,
            CupertinoPageRoute(builder: (context) => DetailsWidget(item))));
  }
}
