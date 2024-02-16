import '../../../domain/model/theme_type.dart';
import '../../cache/model/settings_cache.dart';
import '../../cache/settings/settings_cache_client.dart';
import 'mappers/theme_type_mapper.dart';

class SettingsRepository {
  SettingsRepository({required SettingsCacheClient settingsCacheClient})
      : _settingsCacheClient = settingsCacheClient;

  final SettingsCacheClient _settingsCacheClient;

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

  ThemeType? getThemeType() => _settingsCacheClient.get()?.themeType.toDomain();

  Stream<ThemeType?> observeThemeType() => _settingsCacheClient.observe().map(
        (data) => data?.themeType.toDomain(),
      );

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

  String? getLocaleCode() => _settingsCacheClient.get()?.localeCode;

  Stream<String?> observeLocaleCode() => _settingsCacheClient.observe().map(
        (data) => data?.localeCode,
      );
}
