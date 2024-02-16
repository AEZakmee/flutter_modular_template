import 'package:domain/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localizations/generated/app_localizations.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../utils/viewmodel_builder.dart';
import 'di/locator.dart';
import 'main_viewmodel.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => ViewModelBuilder<MainViewModel>(
        viewModelBuilder: locator,
        builder: (context, child) {
          final isAuthenticated = locator<Auth>().isAuthenticated;
          final viewModel = context.watch<MainViewModel>();
          final appTheme = AppTheme(
            brightness: viewModel.brightness,
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: appTheme.theme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: viewModel.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: isAuthenticated ? Routes.home : Routes.initial,
            onGenerateRoute: onGenerateRoute,
          );
        },
      );
}
