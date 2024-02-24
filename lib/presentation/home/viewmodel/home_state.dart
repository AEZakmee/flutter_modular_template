import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/cocktail/cocktail.dart';
import '../../model/answer_ui.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<Cocktail> cocktails,
    required List<AnswerUI> answers,
  }) = _HomeState;
}

extension HomeStateFunctions on HomeState {
  int get cocktailsLength => cocktails.length;
}
