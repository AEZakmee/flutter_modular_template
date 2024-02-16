import '../../../domain/model/user/user_tokens.dart';
import '../../cache/model/user_tokens_cache.dart';
import '../../cache/user/user_tokens_cache_client.dart';

class UserRepository {
  UserRepository({
    required UserTokensCacheClient tokensCacheClient,
  }) : _tokensCacheClient = tokensCacheClient;

  final UserTokensCacheClient _tokensCacheClient;

  Future<void> saveUserTokens(UserTokens tokens) async {
    await _tokensCacheClient.put(
      data: UserTokensCache(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }

  Future<void> clearUserTokens() async {
    await _tokensCacheClient.delete();
  }

  UserTokens getUserTokens() {
    final tokens = _tokensCacheClient.get();

    if (tokens != null) {
      return UserTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    }

    return UserTokens.empty();
  }

  Stream<UserTokensCache> observeTokens() => _tokensCacheClient
      .observe()
      .map((data) => data ?? UserTokensCache(accessToken: ''));
}
