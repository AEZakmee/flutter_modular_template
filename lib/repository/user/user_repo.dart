import '../../app/model/user_tokens.dart';
import '../../datasource/cache/models/user_tokens_cache.dart';
import '../../datasource/cache/user/user_tokens_cache_client.dart';

class UserRepository {
  UserRepository({required UserTokensCacheClient tokensCacheClient})
      : _tokensCacheClient = tokensCacheClient;

  final UserTokensCacheClient _tokensCacheClient;

  Future<void> saveUserTokens(UserTokens tokens) async {
    await _tokensCacheClient.save(
      data: UserTokensCache(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }

  Future<void> clearUserTokens() async {
    await _tokensCacheClient.clear();
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
