import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildSlideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

CustomTransitionPage buildPageWithInstantTransition<T>({
  required Widget child,
}) {
  return NoTransitionPage(child: child);
}
