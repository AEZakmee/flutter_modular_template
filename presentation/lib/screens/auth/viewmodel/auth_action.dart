import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_action.freezed.dart';

@freezed
class AuthAction with _$AuthAction {
  const factory AuthAction.logIn() = _LogIn;
}
