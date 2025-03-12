import 'package:flutter/material.dart';

final class DialogHelper {
  DialogHelper(this.context);

  final BuildContext context;

  Future<void> showConfirmationDialog({
    required String title,
    required String message,
    required String buttonText,
    Function()? onConfirm,
  }) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              onConfirm?.call();
              Navigator.pop(context);
            },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}
