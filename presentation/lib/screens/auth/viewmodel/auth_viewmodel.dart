import 'package:domain/services/auth.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../utils/state_viewmodel.dart';
import 'auth_action.dart';
import 'auth_event.dart';
import 'auth_state.dart';

final class AuthViewModel
    extends StateViewModel<AuthState, AuthAction, AuthEvent> {
  AuthViewModel({
    required Auth auth,
    required GoRouter router,
  })  : _auth = auth,
        _router = router,
        super(initialState: const AuthState());

  final Auth _auth;
  final GoRouter _router;

  @override
  Future<void> submitAction(AuthAction action) async {
    await action.when(
      logIn: _logIn,
    );
  }

  Future<void> _logIn() async {
    final success = await _auth.signIn();

    if (success) {
      _router.goNamed(Routes.home);
    } else {
      submitEvent(const AuthEvent.showError());
    }
  }
}
