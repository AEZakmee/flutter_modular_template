import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/cocktails/cocktail_ui.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<CocktailUI> cocktails,
  }) = _HomeState;
}

extension HomeStateFunctions on HomeState {
  int get cocktailsLength => cocktails.length;
}
