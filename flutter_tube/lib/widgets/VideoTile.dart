import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/blocs/FavoritesBloc.dart';
import 'package:flutter_tube/models/VideoModel.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoTile extends StatelessWidget {
  final VideoModel video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritesBloc>(context);

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8, top: 8, right: 8, bottom: 0),
                        child: Text(
                          video.title,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder<Map<String, VideoModel>>(
                  stream: bloc.outFavVideos,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          bloc.toggleFavorite(video);
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
      },
    );
  }
}
