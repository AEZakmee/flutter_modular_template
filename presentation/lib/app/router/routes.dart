import 'package:go_router/go_router.dart';

import '../../screens/auth/auth_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../sheets/cocktail_details/cocktail_details_sheet.dart';

class Routes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String details = 'details';
}

final routes = [
  GoRoute(
    path: Routes.home,
    builder: (_, __) => const HomeScreen(),
    routes: [
      GoRoute(
        name: Routes.details,
        path: '${Routes.details}/:id',
        builder: (_, state) => CocktailDetailsSheet(
          cocktailId: state.pathParameters['id']!,
        ),
      ),
    ],
  ),
  GoRoute(
    path: Routes.auth,
    builder: (_, __) => const AuthScreen(),
  ),
];
