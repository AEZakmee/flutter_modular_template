import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../config/remote_config.dart';
import '../firebase_options.dart';
import 'locator.dart';

Future<void> setupFirebase() async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator
    ..registerLazySingleton(() => app)
    ..registerLazySingleton(
      () => FirebaseRemoteConfig.instanceFor(app: locator()),
    )
    ..registerLazySingleton(() => FirebaseAnalytics.instanceFor(app: locator()))
    ..registerLazySingleton(
      () => RemoteConfig(firebaseRemoteConfig: locator()),
    );

  await locator<FirebaseRemoteConfig>().setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: kDebugMode ? 1 : 60),
    ),
  );
  await locator<FirebaseRemoteConfig>().fetchAndActivate();
}
