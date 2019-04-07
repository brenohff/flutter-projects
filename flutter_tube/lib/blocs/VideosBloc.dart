import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/models/VideoModel.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<VideoModel> _videosList;

  final _videosController = StreamController<List<VideoModel>>();

  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);
      _videosList = await api.searchVideo(search);
    } else {
      _videosList += await api.nextPage();
    }

    _videosController.sink.add(_videosList);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
