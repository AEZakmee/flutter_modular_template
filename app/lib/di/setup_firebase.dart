import 'package:domain/constants/remote_config_constants.dart';
import 'package:domain/model/api_type.dart';
import 'package:domain/model/login_type.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../firebase_options.dart';
import 'locator.dart';

Future<void> setupFirebase() async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator
    ..registerLazySingleton(() => app)
    ..registerLazySingleton(
      () => FirebaseRemoteConfig.instanceFor(
        app: locator(),
      ),
    )
    ..registerLazySingleton(
      () => FirebaseAuth.instanceFor(
        app: locator(),
      ),
    )
    ..registerLazySingleton(
      () => FirebaseAnalytics.instanceFor(
        app: locator(),
      ),
    );

  await locator<FirebaseRemoteConfig>().setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ),
  );
  await locator<FirebaseRemoteConfig>().setDefaults({
    RemoteConfigConsts.loginType: LoginType.custom.id,
    RemoteConfigConsts.apiType: ApiType.local.id,
  });
  await locator<FirebaseRemoteConfig>().fetchAndActivate();
}
