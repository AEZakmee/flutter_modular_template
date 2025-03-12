import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:localizations/generated/app_localizations.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../utils/viewmodel_builder.dart';
import 'di/locator.dart';
import 'main_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>(
      viewModelBuilder: locator,
      builder: (context, child) {
        final viewModel = context.watch<MainViewModel>();
        final appTheme = AppTheme(brightness: viewModel.brightness);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: appTheme.theme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: viewModel.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: locator<GoRouter>(),
        );
      },
    );
  }
}
