import 'package:domain/model/theme_type.dart';
import 'package:domain/repositories/settings_repository.dart';

import '../../datasource/cache/models/settings_cache.dart';
import '../../datasource/cache/settings/settings_cache_client.dart';
import 'mappers/theme_type_mapper.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SettingsCacheClient settingsCacheClient})
      : _settingsCacheClient = settingsCacheClient;

  final SettingsCacheClient _settingsCacheClient;

  @override
  Future<void> saveThemeType(ThemeType themeType) async {
    final data = _settingsCacheClient.get();

    if (data != null) {
      data.themeType = themeType.toCache();
      await data.save();
      return;
    }

    await _settingsCacheClient.put(
      data: SettingsCache(themeType: themeType.toCache()),
    );
  }

  @override
  ThemeType? getThemeType() => _settingsCacheClient.get()?.themeType.toDomain();

  @override
  Stream<ThemeType?> observeThemeType() => _settingsCacheClient.observe().map(
        (data) => data?.themeType.toDomain(),
      );

  @override
  Future<void> saveLocaleCode(String code) async {
    final data = _settingsCacheClient.get();

    if (data != null) {
      data.localeCode = code;
      await data.save();
      return;
    }

    await _settingsCacheClient.put(
      data: SettingsCache(localeCode: code),
    );
  }

  @override
  String? getLocaleCode() => _settingsCacheClient.get()?.localeCode;

  @override
  Stream<String?> observeLocaleCode() => _settingsCacheClient.observe().map(
        (data) => data?.localeCode,
      );
}
