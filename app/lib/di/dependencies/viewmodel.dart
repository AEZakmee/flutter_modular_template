import 'package:presentation/app/main_viewmodel.dart';
import 'package:presentation/home/viewmodel/home_viewmodel.dart';
import 'package:presentation/welcome/welcome_viewmodel.dart';

import '../locator.dart';

void viewmodel() {
  locator

    ///View models
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
