import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../../utils/viewmodel_builder.dart';
import '../../utils/viewmodel_event_handler.dart';
import 'viewmodel/{{name.snakeCase()}}_event.dart';
import 'viewmodel/{{name.snakeCase()}}_viewmodel.dart';
import 'widgets/{{name.snakeCase()}}_body.dart';

class {{name.pascalCase()}}Screen extends StatelessWidget {
  const {{name.pascalCase()}}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<{{name.pascalCase()}}ViewModel>(
      viewModelBuilder: locator,
      builder: (context, viewModel) => Scaffold(
        body: ViewModelEventHandler<{{name.pascalCase()}}Event>(
          viewModel: viewModel,
          onEvent: (event) {
            event.when(
              somethingWentWrong: () {},
            );
          },
          child: {{name.pascalCase()}}Body(
            submitAction: viewModel.submitAction,
          ),
        ),
      ),
    );
  }
}