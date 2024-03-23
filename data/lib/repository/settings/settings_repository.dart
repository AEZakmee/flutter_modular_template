import 'package:domain/model/settings/theme_type.dart';
import 'package:domain/repositories/settings_repository.dart';

import '../../cache/cache_handler.dart';
import '../../cache/settings/locale_cache_client.dart';
import '../../cache/settings/theme_type_cache_client.dart';
import 'mappers/theme_type_mapper.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required LocaleCacheClient localeCacheClient,
    required ThemeTypeCacheClient themeTypeCacheClient,
    required CacheHandler cacheHandler,
  })  : _localeCacheClient = localeCacheClient,
        _themeTypeCacheClient = themeTypeCacheClient,
        _cacheHandler = cacheHandler;

  final LocaleCacheClient _localeCacheClient;
  final ThemeTypeCacheClient _themeTypeCacheClient;
  final CacheHandler _cacheHandler;

  @override
  Future<void> updateThemeType(ThemeType themeType) async {
    await _themeTypeCacheClient.put(data: themeType.toCache());
  }

  @override
  ThemeType? getThemeType() => _themeTypeCacheClient.get()?.toDomain();

  @override
  Stream<ThemeType?> observeThemeType() => _themeTypeCacheClient.observe().map(
        (data) => data?.toDomain(),
      );

  @override
  Future<void> updateLocaleCode(String code) async {
    await _localeCacheClient.put(data: code);
  }

  @override
  Stream<String?> observeLocaleCode() => _localeCacheClient.observe();

  @override
  Future<void> clearCache() => _cacheHandler.clearCache();
}
