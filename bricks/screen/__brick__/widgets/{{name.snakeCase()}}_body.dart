import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';
import '../viewmodel/{{name.snakeCase()}}_action.dart';

class {{name.pascalCase()}}Body extends StatelessWidget {
  const {{name.pascalCase()}}Body({
    required this.submitAction,
    super.key,
  });

  final Function({{name.pascalCase()}}Action) submitAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => submitAction(const {{name.pascalCase()}}Action.doSomething()),
          child: Text(context.localizations.login),
        ),
      ],
    ),
  );
}