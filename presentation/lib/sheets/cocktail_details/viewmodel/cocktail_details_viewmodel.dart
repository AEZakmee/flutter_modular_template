import 'package:domain/services/cocktails_service.dart';
import 'package:domain/utils/extensions.dart';

import '../../../mappers/cocktail/cocktail_mapper.dart';
import '../../../model/cocktails/cocktail_ui.dart';
import '../../../utils/state_viewmodel.dart';
import 'cocktail_details_action.dart';
import 'cocktail_details_event.dart';
import 'cocktail_details_state.dart';

final class CocktailDetailsViewModel extends StateViewModel<
    CocktailDetailsState, CocktailDetailsAction, CocktailDetailsEvent> {
  CocktailDetailsViewModel({
    required String cocktailId,
    required CocktailsService cocktailsService,
  })  : _cocktailId = cocktailId,
        _cocktailsService = cocktailsService,
        super(
          initialState: CocktailDetailsState(
            cocktail: CocktailUI.empty(),
          ),
        );

  final String _cocktailId;
  final CocktailsService _cocktailsService;

  @override
  Future<void> init() async {
    //Fake waiting, to show UI state builder
    await Future.delayed(const Duration(seconds: 1));

    _cocktailsService.getCocktail(_cocktailId).fold(
      onSuccess: (data) {
        state = state.copyWith(cocktail: data.toUI());
        success();
      },
      onError: (_) {
        failure();
      },
    );
  }

  @override
  Future<void> submitAction(CocktailDetailsAction action) async {
    await action.when(
      toggleFavorite: _toggleFavorite,
    );
  }

  Future<void> _toggleFavorite() async {
    final updatedCocktail = state.cocktail.copyWith(
      favorite: !state.cocktail.favorite,
    );

    updateState(
      state.copyWith(
        cocktail: updatedCocktail,
      ),
    );

    await _cocktailsService.updateCocktail(updatedCocktail.toDomain());
    submitEvent(const CocktailDetailsEvent.showFavoriteSuccess());
  }
}
