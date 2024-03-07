import 'package:flutter/material.dart';

class CloseKeyboardOnTap extends StatelessWidget {
  const CloseKeyboardOnTap({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}
