import 'package:domain/model/login_type.dart';
import 'package:domain/services/answers_service.dart';
import 'package:domain/services/auth/auth.dart';
import 'package:domain/services/auth/custom_auth_impl.dart';
import 'package:domain/services/auth/firebase_auth_impl.dart';
import 'package:domain/services/localization_service.dart';
import 'package:domain/services/remote_config.dart';
import 'package:domain/services/theme_service.dart';
import 'package:domain/usecases/cocktails/fetch_coctails_use_case.dart';

import '../locator.dart';

void service() {
  locator

    ///Services
    ..registerLazySingleton(
      () => RemoteConfig(
        firebaseRemoteConfig: locator(),
      ),
    )
    ..registerLazySingleton<Auth>(() {
      return switch (locator<RemoteConfig>().loginType) {
        LoginType.custom => CustomAuthImpl(
            userRepository: locator(),
          ),
        LoginType.firebase => FirebaseAuthImpl(
            firebaseAuth: locator(),
          )
      };
    })
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

    ///Use Cases
    ..registerLazySingleton(
      () => FetchCocktailsUseCase(
        cocktailsRepo: locator(),
      ),
    );
}
