import 'package:flutter/material.dart';

import '../../../utils/dialog_helper.dart';
import '../../../utils/extensions.dart';
import '../viewmodel/home_action.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({required this.submitAction, super.key});

  final Function(HomeAction) submitAction;

  @override
  Widget build(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed:
          () => DialogHelper(context).showConfirmationDialog(
            title: context.localizations.logout,
            message: context.localizations.areYouSureLogout,
            buttonText: context.localizations.confirm,
            onConfirm: () => submitAction(const HomeAction.logOut()),
          ),
      icon: const Icon(Icons.logout),
    ),
    actions: [
      IconButton(
        onPressed: () => submitAction(const HomeAction.switchTheme()),
        icon: const Icon(Icons.dark_mode),
      ),
    ],
  );

  @override
  Size get preferredSize => AppBar().preferredSize;
}
