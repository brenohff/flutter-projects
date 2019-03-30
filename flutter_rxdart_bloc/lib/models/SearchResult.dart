import 'package:flutter_rxdart_bloc/models/SearchItem.dart';

class SearchResult {
  final List<SearchItem> itemsList;

  SearchResult(this.itemsList);

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final listItems = (json["items"] as List).cast<Map<String, dynamic>>()?.map((item) {
      return SearchItem.fromJson(item);
    })?.toList();

    return SearchResult(listItems);
  }
}
