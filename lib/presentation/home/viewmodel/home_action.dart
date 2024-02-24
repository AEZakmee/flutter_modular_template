import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_action.freezed.dart';

@freezed
class HomeAction with _$HomeAction {
  const factory HomeAction.addAnswer(int answer) = AddAnswer;
  const factory HomeAction.clearAnswers() = ClearAnswers;
  const factory HomeAction.logOut() = LogOut;
}
