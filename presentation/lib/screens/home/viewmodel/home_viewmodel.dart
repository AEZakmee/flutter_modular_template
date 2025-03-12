import 'package:domain/services/auth.dart';

import '../../../controllers/theme_controller.dart';
import '../../../utils/state_viewmodel.dart';
import 'home_action.dart';
import 'home_event.dart';
import 'home_state.dart';

final class HomeViewModel
    extends StateViewModel<HomeState, HomeAction, HomeEvent> {
  HomeViewModel({required ThemeController themeController, required Auth auth})
    : _themeController = themeController,
      _auth = auth,
      super(initialState: const HomeState(somethingWentWrong: false));

  final ThemeController _themeController;
  final Auth _auth;

  @override
  Future<void> submitAction(HomeAction action) async {
    await action.when(
      logOut: _logOut,
      switchTheme: _themeController.switchBrightness,
    );
  }

  Future<void> _logOut() => _auth.signOut();
}
