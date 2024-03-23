import '../../constants/storage_consts.dart';
import '../generic_cache_client.dart';

class LocaleCacheClient extends GenericCacheClient<String> {
  LocaleCacheClient({required super.box});

  @override
  String key = StorageConsts.locale;
}
