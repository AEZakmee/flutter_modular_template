import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../../app/di/locator.dart';
import '../theme/app_theme.dart';
import '../utils/viewmodel_builder.dart';
import 'main_viewmodel.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.initialRoute,
    super.key,
  });
  final String initialRoute;
  @override
  Widget build(BuildContext context) => ViewModelBuilder<MainViewModel>(
        viewModelBuilder: locator,
        builder: (context, child) {
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
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
          );
        },
      );
}
