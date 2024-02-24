import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_viewmodel.dart';

final class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  const ViewModelBuilder({
    required this.viewModelBuilder,
    required this.builder,
    this.child,
    this.lazy = false,
    super.key,
  });

  final T Function() viewModelBuilder;
  final Widget Function(BuildContext, T) builder;
  final Widget? child;
  final bool lazy;

  @override
  State<ViewModelBuilder<T>> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends BaseViewModel>
    extends State<ViewModelBuilder<T>> {
  late T _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder();
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>(
        lazy: widget.lazy,
        create: (context) => _viewModel,
        builder: (context, _) => widget.builder(context, _viewModel),
        child: widget.child,
      );
}
