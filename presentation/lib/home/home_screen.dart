import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../utils/ui_state_builder.dart';
import '../utils/viewmodel_builder.dart';
import '../utils/viewmodel_event_handler.dart';
import 'viewmodel/home_event.dart';
import 'viewmodel/home_viewmodel.dart';
import 'widgets/app_bar.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder<HomeViewModel>(
        viewModelBuilder: locator,
        builder: (context, viewModel) => Scaffold(
          body: ViewModelEventHandler<HomeEvent>(
            viewModel: viewModel,
            onEvent: (event) {
              event.when(
                showError: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This is event snack-bar'),
                    ),
                  );
                },
              );
            },
            child: UIStateBuilder<HomeViewModel>(
              successState: HomeBody(
                submitAction: viewModel.submitAction,
              ),
            ),
          ),
          appBar: const MainAppBar(),
        ),
      );
}
