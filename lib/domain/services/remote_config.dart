import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../constants/remote_config_constants.dart';
import '../model/api_type.dart';
import '../model/login_type.dart';

class RemoteConfig {
  RemoteConfig({
    required FirebaseRemoteConfig firebaseRemoteConfig,
  }) : _firebaseRemoteConfig = firebaseRemoteConfig;

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  LoginType get loginType {
    final typeId = _firebaseRemoteConfig.getInt(
      RemoteConfigConsts.loginType,
    );
    return LoginType.getType(typeId);
  }

  ApiType get apiType {
    final typeId = _firebaseRemoteConfig.getInt(
      RemoteConfigConsts.apiType,
    );
    return ApiType.getType(typeId);
  }
}
