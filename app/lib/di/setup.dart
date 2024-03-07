import 'package:data/storage.dart';

import 'dependencies/api.dart';
import 'dependencies/asset.dart';
import 'dependencies/cache.dart';
import 'dependencies/repository.dart';
import 'dependencies/service.dart';
import 'dependencies/viewmodel.dart';
import 'setup_environment.dart';
import 'setup_firebase.dart';

Future<void> setupDependencies() async {
  await setupEnvironment();

  await setupFirebase();
  await setupStorage();

  api();
  asset();
  cache();
  repository();
  service();
  viewmodel();
}
