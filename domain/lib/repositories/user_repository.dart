import '../model/user_tokens.dart';

abstract interface class UserRepository {
  Future<void> saveUserTokens(UserTokens tokens);
  Future<void> clearUserTokens();
  UserTokens getUserTokens();
  Stream<UserTokens> observeTokens();
}
