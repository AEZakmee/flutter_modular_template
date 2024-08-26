import 'package:go_router/go_router.dart';

import '../../screens/auth/auth_screen.dart';
import '../../screens/cocktail_details/cocktail_details_sheet.dart';
import '../../screens/home/home_screen.dart';
import 'dialog_page.dart';
import 'transitions.dart';

class Routes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String details = 'details';
}

final routes = [
  GoRoute(
    path: Routes.home,
    name: Routes.home,
    builder: (_, __) => const HomeScreen(),
    routes: [
      GoRoute(
        name: Routes.details,
        path: '${Routes.details}/:id',
        pageBuilder: (context, state) {
          final showSheetValue = state.uri.queryParameters['showSheet'];
          final showSheet = bool.tryParse(showSheetValue ?? '') ?? false;
          final id = state.pathParameters['id']!;

          if (showSheet) {
            return DialogPage<void>(
              child: CocktailDetailsSheet(
                cocktailId: id,
              ),
            );
          }
          return buildSlideTransition(
            child: CocktailDetailsSheet(
              cocktailId: id,
            ),
            context: context,
            state: state,
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: Routes.auth,
    name: Routes.auth,
    builder: (_, __) => const AuthScreen(),
  ),
];
