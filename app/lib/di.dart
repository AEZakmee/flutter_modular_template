import 'package:data/di.dart';
import 'package:domain/di.dart';
import 'package:presentation/di.dart';

Future<void> setupApp() async {
  await setupData();
  await setupDomain();
  await setupPresentation();
}
