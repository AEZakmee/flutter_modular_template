import '../../../utils/state_viewmodel.dart';
import '{{name.snakeCase()}}_action.dart';
import '{{name.snakeCase()}}_event.dart';
import '{{name.snakeCase()}}_state.dart';

final class {{name.pascalCase()}}ViewModel extends StateViewModel<{{name.pascalCase()}}State,
{{name.pascalCase()}}Action, {{name.pascalCase()}}Event> {
{{name.pascalCase()}}ViewModel()
      : super(
    initialState: const {{name.pascalCase()}}State(
      pending: false,
    ),
  );

  @override
  Future<void> submitAction({{name.pascalCase()}}Action action) async {
    action.when(
      doSomething: _doSomething,
    );
  }

  void _doSomething() {
    submitEvent(const {{name.pascalCase()}}Event.doSomething());
    updateState(state.copyWith(pending: true));
  }
}
