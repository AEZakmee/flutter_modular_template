import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/ui_state.dart';
import 'base_viewmodel.dart';

class UIStateBuilder<T extends BaseViewModel> extends StatelessWidget {
  const UIStateBuilder({
    required this.successState,
    this.errorState,
    this.loadingState,
    super.key,
  });

  final Widget successState;
  final Widget? errorState;
  final Widget? loadingState;

  @override
  Widget build(BuildContext context) {
    return switch (context.select((T viewModel) => viewModel.uiState)) {
      UIState.success => successState,
      UIState.error => errorState ?? const Text('Something went wrong'),
      UIState.loading => const Center(
          child: CircularProgressIndicator(),
        )
    };
  }
}
