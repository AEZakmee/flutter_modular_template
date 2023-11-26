import 'package:flutter/material.dart';

import '../app/di/locator.dart';
import '../utils/viewmodel_builder.dart';
import 'home_viewmodel.dart';
import 'widgets/app_bar.dart';
import 'widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder<HomeViewModel>(
        viewModelBuilder: locator,
        builder: (context, viewModel) => const Scaffold(
          body: Body(),
          appBar: MainAppBar(),
        ),
      );
}
