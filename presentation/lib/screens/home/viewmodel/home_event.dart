import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.openCocktailSheet(String id) = _OpenCocktailSheet;
  const factory HomeEvent.showFeatureDisabled() = _ShowFeatureDisabled;
}
