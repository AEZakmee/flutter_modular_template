import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/main_viewmodel.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<MainViewModel>().switchTheme(),
            icon: const Icon(Icons.adjust),
          ),
        ],
      );

  @override
  Size get preferredSize => AppBar().preferredSize;
}
