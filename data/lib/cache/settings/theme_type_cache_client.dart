import '../../constants/storage_consts.dart';
import '../generic_cache_client.dart';
import '../model/settings/theme_type_cache.dart';

class ThemeTypeCacheClient extends GenericCacheClient<ThemeTypeCache> {
  ThemeTypeCacheClient({required super.box});

  @override
  String key = StorageConsts.themeType;
}
