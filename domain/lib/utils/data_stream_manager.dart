import 'dart:async';

import '../model/handler/data_response.dart';
import 'base_stream_manager.dart';

class DataStreamManager<T> implements BaseStreamManager {
  DataStreamManager({required this.fetchFunction, this.hotObservable = true});

  final Future<DataResponse<T>> Function() fetchFunction;
  final bool hotObservable;
  final _controller = StreamController<DataResponse<T>>.broadcast();
  DataResponse<T> _data = FailureDataResponse<T>();
  DataResponse<T> get data => _data;

  Stream<DataResponse<T>> stream({bool fetchOnObserve = true}) async* {
    if (hotObservable && _data is SuccessfulDataResponse) {
      yield _data;
    }
    if (fetchOnObserve) {
      unawaited(refetch());
    }
    yield* _controller.stream;
  }

  Future<DataResponse<T>> fetch() async {
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
    _data = FailureDataResponse();
    _controller.add(_data);
  }

  @override
  void dispose() {
    _controller.close();
  }

  void push(DataResponse<T> data) {
    _controller.add(_data = data);
  }
}
