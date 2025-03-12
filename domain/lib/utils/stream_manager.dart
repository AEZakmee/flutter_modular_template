import 'dart:async';

import 'base_stream_manager.dart';

class StreamManager<T> implements BaseStreamManager {
  StreamManager({required this.fetchFunction, this.hotObservable = true});

  final Future<T?> Function() fetchFunction;
  final bool hotObservable;
  final _controller = StreamController<T?>.broadcast();
  T? _data;
  T? get data => _data;

  Stream<T?> stream({bool fetchOnObserve = true}) async* {
    if (hotObservable) {
      yield _data;
    }
    if (fetchOnObserve) {
      unawaited(refetch());
    }
    yield* _controller.stream;
  }

  Future<T?> fetch() async {
    await refetch();
    return data;
  }

  Future<void> refetch() async {
    final response = await fetchFunction();
    _data = response;
    _controller.add(response);
  }

  @override
  void clear() {
    _data = null;
    _controller.add(_data);
  }

  @override
  void dispose() {
    _controller.close();
  }

  void push(T? data) {
    _controller.add(_data = data);
  }
}
