import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../../utils/extensions.dart';
import '../../utils/snack_bar_helper.dart';
import '../../utils/viewmodel_builder.dart';
import '../../utils/viewmodel_event_handler.dart';
import 'viewmodel/home_event.dart';
import 'viewmodel/home_viewmodel.dart';
import 'widgets/app_bar.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      viewModelBuilder: locator,
      builder:
          (context, viewModel) => Scaffold(
            body: ViewModelEventHandler<HomeEvent>(
              viewModel: viewModel,
              onEvent: (event) {
                event.when(
                  showSomethingWentWrong:
                      () => SnackBarHelper(
                        context,
                      ).showErrorSnackBar(context.localizations.genericError),
                );
              },
              child: HomeBody(submitAction: viewModel.submitAction),
            ),
            appBar: MainAppBar(submitAction: viewModel.submitAction),
          ),
    );
  }
}
