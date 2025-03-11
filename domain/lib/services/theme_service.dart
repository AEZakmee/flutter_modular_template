import '../model/settings/theme_type.dart';
import '../repositories/settings_repository.dart';
import '../utils/stream_manager.dart';
import 'cache_service.dart';

class ThemeService {
  ThemeService({
    required SettingsRepository settingsRepository,
    required CacheService cacheService,
  }) : _settingsRepository = settingsRepository {
    manager = StreamManager<ThemeType>(
      fetchFunction: settingsRepository.getThemeType,
    );
    cacheService.addManager(manager);
  }

  final SettingsRepository _settingsRepository;

  late final StreamManager<ThemeType?> manager;

  Future<void> switchTheme({required ThemeType currentTheme}) async {
    final newTheme = switch (currentTheme) {
      ThemeType.light => ThemeType.dark,
      ThemeType.dark => ThemeType.light,
    };
    await _settingsRepository.updateThemeType(newTheme);
    await manager.refetch();
  }
}
