import 'package:flutter_rxdart_bloc/models/SearchResult.dart';
import 'package:flutter_rxdart_bloc/service/GithubService.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final GitHubService _gitHubAPI = GitHubService();

  final _searchController = new BehaviorSubject<String>();

  Observable<String> get searchFlux => _searchController.stream;

  Sink<String> get searchEvent => _searchController.sink;

  Observable<SearchResult> listItems;

  HomeBloc() {
    listItems = searchFlux
        .distinct()
        .debounce(Duration(microseconds: 300))
        .asyncMap(_gitHubAPI.search)
        .switchMap((data) => Observable.just(data));
  }

  void dispose(){
    _searchController?.close();
  }
}
