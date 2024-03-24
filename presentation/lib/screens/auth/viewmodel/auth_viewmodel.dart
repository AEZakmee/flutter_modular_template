import 'package:domain/services/auth.dart';

import '../../../utils/state_viewmodel.dart';
import 'auth_action.dart';
import 'auth_event.dart';
import 'auth_state.dart';

final class AuthViewModel
    extends StateViewModel<AuthState, AuthAction, AuthEvent> {
  AuthViewModel({
    required Auth auth,
  })  : _auth = auth,
        super(initialState: const AuthState());

  final Auth _auth;

  @override
  Future<void> submitAction(AuthAction action) async {
    await action.when(
      logIn: _logIn,
    );
  }

  Future<void> _logIn() async {
    final success = await _auth.signIn();

    if (!success) {
      submitEvent(const AuthEvent.showError());
    }
  }
}
