import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_action.freezed.dart';

@freezed
class {{name.pascalCase()}}Action with _${{name.pascalCase()}}Action {
  const factory {{name.pascalCase()}}Action.submit() = _Submit;
}