import '../../../app/constants/storage_consts.dart';
import '../generic_cache_client.dart';
import '../models/user_tokens_cache.dart';

class UserTokensCacheClient extends GenericCacheClient<UserTokensCache> {
  UserTokensCacheClient({required super.box});

  @override
  String key = StorageConsts.userTokens;
}
