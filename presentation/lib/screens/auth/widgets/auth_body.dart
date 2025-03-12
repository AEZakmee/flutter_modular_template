import 'package:flutter/material.dart';

import '../../../utils/extensions.dart';
import '../viewmodel/auth_action.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({required this.submitAction, super.key});

  final Function(AuthAction) submitAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => submitAction(const AuthAction.logIn()),
          child: Text(context.localizations.login),
        ),
      ],
    ),
  );
}
