import 'package:domain/model/user/user_tokens.dart';
import 'package:domain/repositories/user_repository.dart';

import '../../cache/model/user_tokens_cache.dart';
import '../../cache/user/user_tokens_cache_client.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserTokensCacheClient tokensCacheClient,
  }) : _tokensCacheClient = tokensCacheClient;

  final UserTokensCacheClient _tokensCacheClient;

  @override
  Future<void> saveUserTokens(UserTokens tokens) async {
    await _tokensCacheClient.put(
      data: UserTokensCache(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }

  @override
  Future<void> clearUserTokens() async {
    await _tokensCacheClient.delete();
  }

  @override
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

  @override
  Stream<UserTokens> observeTokens() =>
      _tokensCacheClient.observe().map((data) {
        if (data != null) {
          return UserTokens(
            accessToken: data.accessToken,
            refreshToken: data.refreshToken,
          );
        }

        return UserTokens.empty();
      });
}
