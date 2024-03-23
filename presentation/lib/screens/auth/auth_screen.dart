import 'package:flutter/material.dart';

import '../../app/di/locator.dart';
import '../../app/router.dart';
import '../../utils/extensions.dart';
import '../../utils/snack_bar_helper.dart';
import '../../utils/viewmodel_builder.dart';
import '../../utils/viewmodel_event_handler.dart';
import 'viewmodel/auth_event.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'widgets/auth_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showError() => SnackBarHelper(context).showErrorSnackBar(
          context.localizations.genericError,
        );

    void navigateToHome() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home,
        (route) => false,
      );
    }

    return ViewModelBuilder<AuthViewModel>(
      viewModelBuilder: locator,
      builder: (context, viewModel) => Scaffold(
        body: ViewModelEventHandler<AuthEvent>(
          viewModel: viewModel,
          onEvent: (event) {
            event.when(
              showError: showError,
              navigateHome: navigateToHome,
            );
          },
          child: AuthBody(
            submitAction: viewModel.submitAction,
          ),
        ),
      ),
    );
  }
}
