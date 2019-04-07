import 'dart:convert';

import 'package:flutter_tube/models/VideoModel.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyA4BUv2qEleEnf95F6JT5szwP5uKXzgtqs";

/*
"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
 */

class Api {
  String _search;
  String _nextToken;

  Future<List<VideoModel>> searchVideo(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  List<VideoModel> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<VideoModel> videoList = decoded["items"].map<VideoModel>((video) {
        return VideoModel.fromJson(video);
      }).toList();

      return videoList;
    } else {
      throw Exception("Failed to load videos");
    }
  }

  Future<List<VideoModel>> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }
}
