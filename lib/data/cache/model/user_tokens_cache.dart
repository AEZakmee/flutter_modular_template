import 'package:hive/hive.dart';

part 'user_tokens_cache.g.dart';

@HiveType(typeId: 0)
class UserTokensCache extends HiveObject {
  UserTokensCache({required this.accessToken, this.refreshToken});

  @HiveField(0)
  String accessToken;

  @HiveField(1)
  String? refreshToken;
}
