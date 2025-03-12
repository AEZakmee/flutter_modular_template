import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_action.freezed.dart';

@freezed
class HomeAction with _$HomeAction {
  const factory HomeAction.logOut() = _LogOut;
  const factory HomeAction.switchTheme() = _SwitchTheme;
}
