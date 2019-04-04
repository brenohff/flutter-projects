import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  var _streamController = BehaviorSubject<int>.seeded(0);

  Observable<int> get outCount => _streamController.stream;

  Sink<int> get event => _streamController.sink;

  void increment() {
    event.add(_streamController.value + 1);
  }

  void decrement() {
    if (_streamController.value > 0) {
      event.add(_streamController.value - 1);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
