import 'package:flutter/material.dart';

import '../screens/auth/auth_screen.dart';
import '../screens/home/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String initial = '/';
  static const String home = 'home';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.initial:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case Routes.home:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    default:
      throw const FormatException('Route not found! Check routes again!');
  }
}
