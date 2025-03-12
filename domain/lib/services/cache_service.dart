import '../repositories/settings_repository.dart';
import '../utils/base_stream_manager.dart';

class CacheService {
  CacheService({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository {
    managers = [];
  }

  final SettingsRepository _settingsRepository;
  late final List<BaseStreamManager> managers;

  void addManager(BaseStreamManager manager) {
    managers.add(manager);
  }

  void clear() {
    _settingsRepository.clearHandlerCache();
    for (final manager in managers) {
      manager.clear();
    }
  }

  void dispose() {
    for (final manager in managers) {
      manager.dispose();
    }
  }
}
