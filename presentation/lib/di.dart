import 'package:core/di/locator.dart';

import 'app/main_viewmodel.dart';
import 'home/home_viewmodel.dart';
import 'welcome/welcome_viewmodel.dart';

Future<void> setupPresentation() async {
  locator
    ..registerFactory(
      () => MainViewModel(
        localizationService: locator(),
        themeService: locator(),
        auth: locator(),
      ),
    )
    ..registerFactory(
      () => HomeViewModel(
        fetchCocktailsUseCase: locator(),
        answersService: locator(),
        auth: locator(),
      ),
    )
    ..registerFactory(
      () => WelcomeViewModel(
        auth: locator(),
      ),
    );
}
