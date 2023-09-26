import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../utils/viewmodel_builder.dart';
import 'welcome_viewmodel.dart';
import 'widgets/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder<WelcomeViewModel>(
        viewModelBuilder: locator<WelcomeViewModel>,
        builder: (context, viewModel) => const Scaffold(
          body: Body(),
        ),
      );
}
