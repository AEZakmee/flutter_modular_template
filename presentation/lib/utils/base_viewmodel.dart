import 'dart:async';

import 'package:flutter/material.dart';

import '../model/ui_state.dart';

abstract base class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  UIState _uiState = UIState.loading;
  UIState get uiState => _uiState;

  void setLoading() {
    _uiState = UIState.loading;
    notifyListeners();
  }

  void setSuccess() {
    _uiState = UIState.success;
    notifyListeners();
  }

  void setError() {
    _uiState = UIState.error;
    notifyListeners();
  }

  Future<void> init() async {}

  void addDisposable(StreamSubscription<dynamic> subscription) {
    _subscriptions.add(subscription);
  }

  @override
  void dispose() {
    _isDisposed = true;

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();

    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }
}
