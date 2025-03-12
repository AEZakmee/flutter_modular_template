import 'package:domain/model/settings/theme_type.dart';
import 'package:domain/repositories/settings_repository.dart';

import '../../cache/cache_handler.dart';
import '../../cache/settings/locale_cache_client.dart';
import '../../cache/settings/theme_type_cache_client.dart';
import '../handler/request_handler.dart';
import 'mappers/theme_type_mapper.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required LocaleCacheClient localeCacheClient,
    required ThemeTypeCacheClient themeTypeCacheClient,
    required RequestHandler requestHandler,
    required CacheHandler cacheHandler,
  }) : _localeCacheClient = localeCacheClient,
       _themeTypeCacheClient = themeTypeCacheClient,
       _requestHandler = requestHandler,
       _cacheHandler = cacheHandler;

  final LocaleCacheClient _localeCacheClient;
  final ThemeTypeCacheClient _themeTypeCacheClient;
  final RequestHandler _requestHandler;
  final CacheHandler _cacheHandler;

  @override
  Future<void> updateThemeType(ThemeType themeType) async {
    await _themeTypeCacheClient.put(data: themeType.name);
  }

  @override
  Future<ThemeType?> getThemeType() =>
      _themeTypeCacheClient.get().then((value) => value.toThemeType());

  @override
  Future<void> updateLocaleCode(String code) async {
    await _localeCacheClient.put(data: code);
  }

  @override
  Future<String?> getLocaleCode() => _localeCacheClient.get();

  @override
  Future<void> clearStorageCache() => _cacheHandler.clearCache();

  @override
  void clearHandlerCache() => _requestHandler.clearCache();
}
