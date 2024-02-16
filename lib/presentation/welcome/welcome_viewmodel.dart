import '../../domain/services/auth/auth.dart';
import '../app/router.dart';
import '../utils/base_viewmodel.dart';

final class WelcomeViewModel extends BaseViewModel {
  WelcomeViewModel({required Auth auth}) : _auth = auth;

  final Auth _auth;

  Future<void> logIn() async {
    await _auth.signIn();
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.home,
      (route) => false,
    );
  }
}
