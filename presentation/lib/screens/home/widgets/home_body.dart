import 'package:flutter/material.dart';

import '../viewmodel/home_action.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({required this.submitAction, super.key});

  final Function(HomeAction) submitAction;

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: SizedBox.shrink());
  }
}
