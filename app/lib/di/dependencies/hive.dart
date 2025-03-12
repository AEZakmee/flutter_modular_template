import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/app/di/locator.dart';

import '../../config/hive_boxes.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  final directory = !kIsWeb ? await getApplicationDocumentsDirectory() : null;
  final collection = await BoxCollection.open('AppDB', {
    HiveBoxes.generic,
  }, path: directory?.path);

  final genericBox = await collection.openBox(HiveBoxes.generic);

  locator
    ..registerLazySingleton(() => collection)
    ..registerLazySingleton(() => genericBox, instanceName: HiveBoxes.generic);
}
