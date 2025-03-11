import 'package:go_router/go_router.dart';

import '../../screens/auth/auth_screen.dart';
import '../../screens/home/home_screen.dart';

class Routes {
  static const String home = '/';
  static const String auth = '/auth';
}

final routes = [
  GoRoute(
    path: Routes.home,
    name: Routes.home,
    builder: (_, __) => const HomeScreen(),
  ),
  GoRoute(
    path: Routes.auth,
    name: Routes.auth,
    builder: (_, __) => const AuthScreen(),
  ),
];
