import '../repositories/settings_repository.dart';
import '../utils/stream_manager.dart';
import 'cache_service.dart';

class LocalizationService {
  LocalizationService({
    required SettingsRepository settingsRepository,
    required CacheService cacheService,
  }) : _settingsRepository = settingsRepository {
    manager = StreamManager<String>(
      fetchFunction: settingsRepository.getLocaleCode,
    );
    cacheService.addManager(manager);
  }

  final SettingsRepository _settingsRepository;

  late final StreamManager<String?> manager;

  Future<void> saveLocaleCode(String code) async {
    await _settingsRepository.updateLocaleCode(code);
    await manager.refetch();
  }
}
