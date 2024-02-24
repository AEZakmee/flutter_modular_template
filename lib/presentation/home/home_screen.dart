import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../utils/ui_state_builder.dart';
import '../utils/viewmodel_builder.dart';
import 'viewmodel/home_viewmodel.dart';
import 'widgets/app_bar.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder<HomeViewModel>(
        viewModelBuilder: locator<HomeViewModel>,
        builder: (context, viewModel) => Scaffold(
          body: UIStateBuilder<HomeViewModel>(
            successState: HomeBody(
              submitAction: viewModel.submitAction,
            ),
          ),
          appBar: const MainAppBar(),
        ),
      );
}
