import 'package:flutter/material.dart';

import 'extensions.dart';

final class SnackBarHelper {
  SnackBarHelper(this.context);

  final BuildContext context;

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colors.secondaryColor,
      ),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colors.errorColor,
      ),
    );
  }

  void showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colors.primaryColor,
      ),
    );
  }
}
