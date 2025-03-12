import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder:
        (context) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            vertical: 68,
            horizontal: 24,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: child,
          ),
        ),
  );
}
