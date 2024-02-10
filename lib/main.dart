import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/di/locator.dart';
import 'app/di/storage.dart';
import 'domain/services/auth_service.dart';
import 'presentation/app/app.dart';
import 'presentation/app/router.dart';

Future<void> initApp() async {
  await setupStorage();
  setup();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Use appFlavor to get the current flavor and set flavor-specific config
  if (appFlavor == 'prod') {
    log('This is the prod app');
  } else if (appFlavor == 'dev') {
    log('This is the dev app');
  }

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  await initApp();

  final bool userAuthenticated = locator<Auth>().isAuthenticated;

  runApp(
    MyApp(
      initialRoute: userAuthenticated ? Routes.home : Routes.initial,
    ),
  );
}
