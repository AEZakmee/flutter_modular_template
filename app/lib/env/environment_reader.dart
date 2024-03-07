import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../flavor/app_flavor.dart';

class EnvironmentReader {
  Future<void> loadEnvironment() async {
    await _loadEnv(AppFlavor.parse(appFlavor));
  }

  Future<void> _loadEnv(AppFlavor flavor) async {
    await dotenv.load(fileName: 'env/.${flavor.fileName}');
  }

  String get baseUrl => dotenv.get('BASE_API_URL');
}
