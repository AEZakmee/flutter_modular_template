import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  RemoteConfig({required FirebaseRemoteConfig firebaseRemoteConfig})
    : _firebaseRemoteConfig = firebaseRemoteConfig;

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  String get baseUrl => _firebaseRemoteConfig.getString('baseUrl');
}
