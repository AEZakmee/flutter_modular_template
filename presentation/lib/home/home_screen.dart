import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../utils/ui_state_builder.dart';
import '../utils/viewmodel_builder.dart';
import 'home_viewmodel.dart';
import 'widgets/app_bar.dart';
import 'widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder<HomeViewModel>(
        viewModelBuilder: locator<HomeViewModel>,
        builder: (context, viewModel) => const Scaffold(
          body: UIStateBuilder<HomeViewModel>(
            successState: Body(),
          ),
          appBar: MainAppBar(),
        ),
      );
}
