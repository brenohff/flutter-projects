import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/blocs/FavoritesBloc.dart';
import 'package:flutter_tube/models/VideoModel.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: bloc.outFavVideos,
        builder: (context, snapshot) {
          return ListView(
              children: snapshot.data.values.map((video) {
            return InkWell(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 50,
                    child: Image.network(video.thumb),
                  ),
                  Expanded(
                    child: Text(
                      video.title,
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                    ),
                  )
                ],
              ),
              onTap: () {
                FlutterYoutube.playYoutubeVideoById(
                    apiKey: API_KEY, videoId: video.id);
              },
              onLongPress: () {
                bloc.toggleFavorite(video);
              },
            );
          }).toList());
        },
      ),
    );
  }
}
