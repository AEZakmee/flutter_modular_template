import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_event.freezed.dart';

@freezed
class {{name.pascalCase()}}Event with _${{name.pascalCase()}}Event {
  const factory {{name.pascalCase()}}Event.somethingWentWrong() = _SomethingWentWrong;
}