import 'package:freezed_annotation/freezed_annotation.dart';

part 'cocktail_details_event.freezed.dart';

@freezed
class CocktailDetailsEvent with _$CocktailDetailsEvent {
  const factory CocktailDetailsEvent.showFavoriteSuccess() =
      _ShowFavoriteSuccess;
}
