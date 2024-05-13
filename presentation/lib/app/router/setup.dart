import 'package:domain/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/locator.dart';
import 'routes.dart';

final allowedUnauthorisedRoutes = [
  Routes.auth,
];

void setupRouter() {
  locator.registerLazySingleton(
    () => GoRouter(
      routes: routes,
      debugLogDiagnostics: true,
      initialLocation: Routes.home,
      errorBuilder: (_, __) => const Center(
        child: Text('404 Not Found'),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        final loggedIn = locator<Auth>().isAuthenticated;
        final loggingIn = allowedUnauthorisedRoutes.any((route) {
          return state.matchedLocation.startsWith(route);
        });

        if (!loggedIn) {
          return loggingIn ? null : Routes.auth;
        }

        return null;
      },
    ),
  );
}
