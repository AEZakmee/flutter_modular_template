import 'dependencies/api.dart';
import 'dependencies/asset.dart';
import 'dependencies/cache.dart';
import 'dependencies/hive.dart';
import 'dependencies/repository.dart';
import 'dependencies/service.dart';
import 'dependencies/viewmodel.dart';
import 'setup_firebase.dart';

Future<void> setupDependencies() async {
  await setupFirebase();
  await setupHive();

  api();
  asset();
  cache();
  repository();
  service();
  viewmodel();
}
