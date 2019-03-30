class SearchItem {
  String fullName;
  String url;
  String avatarUrl;

  SearchItem({this.fullName, this.url, this.avatarUrl});

  static SearchItem fromJson(Map<String, dynamic> item) {
    return SearchItem(
      fullName: item["full_name"] as String,
      url: item["url"] as String,
      avatarUrl: (item["owner"] as Map<String, dynamic>)["avatar_url"] as String,
    );
  }
}
