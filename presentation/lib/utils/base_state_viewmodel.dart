import 'base_viewmodel.dart';

abstract base class BaseStateViewModel<S, A> extends BaseViewModel {
  BaseStateViewModel({required S initialState}) {
    state = initialState;
  }

  late S state;

  Future<void> submitAction(A action) async {}
}
