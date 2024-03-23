import 'package:domain/services/auth.dart';
import 'package:domain/services/cocktails_service.dart';

import '../../../controllers/theme_controller.dart';
import '../../../mappers/cocktail/cocktail_mapper.dart';
import '../../../utils/extensions.dart';
import '../../../utils/state_viewmodel.dart';
import 'home_action.dart';
import 'home_event.dart';
import 'home_state.dart';

final class HomeViewModel
    extends StateViewModel<HomeState, HomeAction, HomeEvent> {
  HomeViewModel({
    required CocktailsService cocktailsService,
    required ThemeController themeController,
    required Auth auth,
    required bool favoriteEnabled,
  })  : _cocktailsService = cocktailsService,
        _themeController = themeController,
        _auth = auth,
        _favoriteEnabled = favoriteEnabled,
        super(
          initialState: HomeState(
            cocktails: List.empty(),
          ),
        );

  final CocktailsService _cocktailsService;
  final ThemeController _themeController;
  final Auth _auth;
  final bool _favoriteEnabled;

  bool get showFavoriteIcon => _favoriteEnabled;

  @override
  Future<void> submitAction(HomeAction action) async {
    action.when(
      logOut: _logOut,
      openCocktail: _openCocktail,
      switchTheme: _themeController.switchBrightness,
    );
  }

  @override
  Future<void> init() async {
    _cocktailsService.observeCocktails().listen((cocktails) {
      updateState(
        state.copyWith(
          cocktails: cocktails.map((cocktail) => cocktail.toUI()).toList(),
        ),
      );
    }).disposeWith(this);
  }

  void _openCocktail(String id) => submitEvent(HomeEvent.openCocktailSheet(id));

  Future<void> _logOut() => _auth.signOut();
}
