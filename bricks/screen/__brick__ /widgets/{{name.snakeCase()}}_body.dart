import 'package:flutter/material.dart';

import '../viewmodel/{{name.snakeCase()}}_action.dart';

class {{name.pascalCase()}}Body extends StatelessWidget {
  const {{name.pascalCase()}}Body({
    required this.submitAction,
    super.key,
  });

  final Function({{name.pascalCase()}}Action) submitAction;

  @override
  Widget build(BuildContext context) => const Center(child: SizedBox.shrink());
}