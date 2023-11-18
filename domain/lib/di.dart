import 'package:core/di/locator.dart';

import 'services/answers_service.dart';
import 'services/auth_service.dart';
import 'services/localization_service.dart';
import 'services/theme_service.dart';
import 'usecases/cocktails/fetch_coctails_use_case.dart';

Future<void> setupDomain() async {
  locator
    ..registerLazySingleton(
      () => Auth(
        userRepository: locator(),
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
      () => AnswersService(
        answerRepository: locator(),
      ),
    )

    //Use Cases
    ..registerLazySingleton(
      () => FetchCocktailsUseCase(
        cocktailsRepo: locator(),
      ),
    );
}
