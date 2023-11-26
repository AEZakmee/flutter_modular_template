import '../model/user_tokens.dart';
import '../repositories/user_repository.dart';

class Auth {
  Auth({
    required UserRepository userRepository,
  }) : _userRepo = userRepository;

  final UserRepository _userRepo;

  Stream<bool> observeAuthentication() => _userRepo.observeTokens().map(
        (data) => data.accessToken.isNotEmpty,
      );

  bool get isAuthenticated => _userRepo.getUserTokens().accessToken.isNotEmpty;

  Future<void> logIn() async {
    //todo: handle login logic

    await _saveTokens(UserTokens(accessToken: 'just-some-token'));
  }

  Future<void> logOut() async {
    await _deleteTokens();
  }

  UserTokens getUserTokens() => _userRepo.getUserTokens();

  String get accessToken => getUserTokens().accessToken;

  Future<void> _saveTokens(UserTokens tokens) async {
    await _userRepo.saveUserTokens(tokens);
  }

  Future<void> _deleteTokens() async {
    await _userRepo.clearUserTokens();
  }
}
