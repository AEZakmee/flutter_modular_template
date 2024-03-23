import 'package:freezed_annotation/freezed_annotation.dart';

part 'cocktail_details_action.freezed.dart';

@freezed
class CocktailDetailsAction with _$CocktailDetailsAction {
  const factory CocktailDetailsAction.toggleFavorite() = _ToggleFavorite;
}
