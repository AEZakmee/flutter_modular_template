import '../../constants/storage_consts.dart';
import '../generic_cache_client.dart';
import '../model/settings_cache.dart';

class SettingsCacheClient extends GenericCacheClient<SettingsCache> {
  SettingsCacheClient({required super.box});

  @override
  String key = StorageConsts.settings;
}
