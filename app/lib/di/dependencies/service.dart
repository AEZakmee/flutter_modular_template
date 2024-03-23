import 'package:domain/services/auth.dart';
import 'package:domain/services/cocktails_service.dart';
import 'package:domain/services/localization_service.dart';
import 'package:domain/services/theme_service.dart';

import '../locator.dart';

void service() {
  locator

    ///Services
    ..registerLazySingleton(
      () => Auth(
        firebaseAuth: locator(),
      ),
    )
    ..registerLazySingleton(
      () => ThemeService(
        settingsRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      () => LocalizationService(
        settingsRepository: locator(),
      ),
    )
    ..registerLazySingleton(
      () => CocktailsService(
        cocktailsRepository: locator(),
      ),
    );
}
