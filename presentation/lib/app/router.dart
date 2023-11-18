import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../welcome/welcome_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String initial = '/';
  static const String home = 'home';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.initial:
      return MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      );
    case Routes.home:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    default:
      throw const FormatException('Route not found! Check routes again!');
  }
}
