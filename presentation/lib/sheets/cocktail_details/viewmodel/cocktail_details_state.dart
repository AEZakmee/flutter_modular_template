import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/cocktails/cocktail_ui.dart';

part 'cocktail_details_state.freezed.dart';

@freezed
class CocktailDetailsState with _$CocktailDetailsState {
  const factory CocktailDetailsState({
    required CocktailUI cocktail,
  }) = _CocktailDetailsState;
}
