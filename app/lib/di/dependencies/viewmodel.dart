import 'package:presentation/app/main_viewmodel.dart';
import 'package:presentation/controllers/theme_controller.dart';
import 'package:presentation/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:presentation/screens/home/viewmodel/home_viewmodel.dart';
import 'package:presentation/sheets/cocktail_details/viewmodel/cocktail_details_viewmodel.dart';

import '../../config/remote_config.dart';
import '../locator.dart';

void viewmodel() {
  locator

    ///Controllers
    ..registerLazySingleton(
      () => ThemeController(
        themeService: locator(),
      ),
    )

    ///View models
    ..registerFactory(
      () => MainViewModel(
        localizationService: locator(),
        themeController: locator(),
        auth: locator(),
        router: locator(),
      ),
    )
    ..registerFactory(
      () => AuthViewModel(
        auth: locator(),
        router: locator(),
      ),
    )
    ..registerFactory(
      () => HomeViewModel(
        cocktailsService: locator(),
        themeController: locator(),
        auth: locator(),
        router: locator(),
        detailsFeature: locator<RemoteConfig>().detailsFeature,
      ),
    )
    ..registerFactoryParam<CocktailDetailsViewModel, String, void>(
      (String cocktailId, _) => CocktailDetailsViewModel(
        cocktailId: cocktailId,
        cocktailsService: locator(),
      ),
    );
}
