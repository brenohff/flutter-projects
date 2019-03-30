import 'package:dio/dio.dart';
import 'package:flutter_rxdart_bloc/models/SearchResult.dart';

class GitHubService {
  final dio = Dio();

  Future<SearchResult> search(String term) async {
    Response response =
        await dio.get("https://api.github.com/search/repositories?q=$term");
    print("$term ${response.data}");
    return SearchResult.fromJson(response.data);
  }
}
