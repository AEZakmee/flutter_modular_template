import 'package:domain/services/auth.dart';
import 'package:domain/services/cache_service.dart';
import 'package:domain/services/localization_service.dart';
import 'package:domain/services/theme_service.dart';

import '../locator.dart';

void service() {
  locator

    ///Services
    ..registerLazySingleton(
      () => CacheService(
        settingsRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      Auth.new,
    )
    ..registerLazySingleton(
      () => ThemeService(
        settingsRepository: locator(),
        cacheService: locator(),
      ),
    )
    ..registerLazySingleton(
      () => LocalizationService(
        settingsRepository: locator(),
        cacheService: locator(),
      ),
    );
}
