import 'dart:async';

import 'base_viewmodel.dart';

abstract base class StateViewModel<S, A, E> extends BaseViewModel {
  StateViewModel({required S initialState}) {
    state = initialState;
  }

  final _eventController = StreamController<E>.broadcast();

  late S state;

  void updateState(S state) {
    this.state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }

  Future<void> submitAction(A action) async {}

  void submitEvent(E event) => _eventController.add(event);

  Stream<E> get events => _eventController.stream;
}
