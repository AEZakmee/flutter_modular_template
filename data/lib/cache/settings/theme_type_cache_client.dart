import '../generic_cache_client.dart';

class ThemeTypeCacheClient extends GenericCacheClient<String> {
  ThemeTypeCacheClient({required super.box});

  @override
  String key = 'theme-client';
}
