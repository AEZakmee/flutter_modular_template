import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/app/app.dart';

import 'di/setup.dart';

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

  await setupDependencies();

  runApp(
    const MyApp(),
  );
}
