import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/models/VideoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc implements BlocBase {
  Map<String, VideoModel> _favorites = {};

  final _favController = BehaviorSubject<Map<String, VideoModel>>.seeded({});

  Stream<Map<String, VideoModel>> get outFavVideos => _favController.stream;

  FavoritesBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((key, value) {
          return MapEntry(key, VideoModel.fromJson(value));
        }).cast<String, VideoModel>();
        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(VideoModel video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);
    _saveFav();
  }

  @override
  void dispose() {
    _favController.close();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }
}
