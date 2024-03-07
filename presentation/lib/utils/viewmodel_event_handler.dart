import 'dart:async';

import 'package:flutter/material.dart';

import 'state_viewmodel.dart';

final class ViewModelEventHandler<E> extends StatefulWidget {
  const ViewModelEventHandler({
    required this.viewModel,
    required this.onEvent,
    required this.child,
    super.key,
  });

  final StateViewModel viewModel;
  final void Function(E) onEvent;
  final Widget child;

  @override
  State<ViewModelEventHandler<E>> createState() =>
      _ViewModelEventHandlerState<E>();
}

class _ViewModelEventHandlerState<E> extends State<ViewModelEventHandler<E>> {
  StreamSubscription<dynamic>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    _eventsSubscription = widget.viewModel.events.listen(
      (event) => widget.onEvent(event as E),
    );
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
