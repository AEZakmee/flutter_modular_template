import 'package:domain/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/locator.dart';
import 'routes.dart';

void setupRouter() {
  locator.registerLazySingleton(
    () => GoRouter(
      routes: routes,
      debugLogDiagnostics: true,
      errorBuilder: (_, __) => const Center(
        child: Text('404 Not Found'),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        final loggedIn = locator<Auth>().isAuthenticated;
        final loggingIn = state.matchedLocation == Routes.auth;

        if (!loggedIn) {
          return loggingIn ? null : Routes.auth;
        }
        if (loggingIn) {
          return Routes.home;
        }
        return null;
      },
    ),
  );
}
