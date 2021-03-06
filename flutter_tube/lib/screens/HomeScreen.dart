import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/FavoritesBloc.dart';
import 'package:flutter_tube/blocs/VideosBloc.dart';
import 'package:flutter_tube/delegates/SearchData.dart';
import 'package:flutter_tube/models/VideoModel.dart';
import 'package:flutter_tube/screens/FavoritesScreen.dart';
import 'package:flutter_tube/widgets/VideoTile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);
    final blocFav = BlocProvider.of<FavoritesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("assets/icons8-reproduzir-youtube-96.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            child: StreamBuilder<Map<String, VideoModel>>(
              stream: blocFav.outFavVideos,
              initialData: {},
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoritesScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
