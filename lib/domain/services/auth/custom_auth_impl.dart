import '../../../data/repository/user/user_repo.dart';
import '../../model/user/user_tokens.dart';
import 'auth.dart';

class CustomAuthImpl implements Auth {
  CustomAuthImpl({
    required UserRepository userRepository,
  }) : _userRepo = userRepository;

  final UserRepository _userRepo;

  @override
  bool get isAuthenticated => _userRepo.getUserTokens().accessToken.isNotEmpty;

  @override
  Future<String> accessToken() async => _userRepo.getUserTokens().accessToken;

  @override
  Stream<bool> observeAuthenticated() => _userRepo.observeTokens().map(
        (data) => data.accessToken.isNotEmpty,
      );

  @override
  Future<void> signIn() async {
    //todo: handle login logic

    await _saveTokens(UserTokens(accessToken: 'just-some-token'));
  }

  @override
  Future<void> signOut() async {
    await _deleteTokens();
  }

  Future<void> _saveTokens(UserTokens tokens) async {
    await _userRepo.saveUserTokens(tokens);
  }

  Future<void> _deleteTokens() async {
    await _userRepo.clearUserTokens();
  }
}
