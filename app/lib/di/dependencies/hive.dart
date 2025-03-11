import 'package:hive_flutter/hive_flutter.dart';
import 'package:presentation/app/di/locator.dart';

import '../../config/hive_boxes.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  final collection = await BoxCollection.open(
    'AppDB',
    {HiveBoxes.generic},
  );

  final genericBox = await collection.openBox(
    HiveBoxes.generic,
  );

  locator
    ..registerLazySingleton(() => collection)
    ..registerLazySingleton(
      () => genericBox,
      instanceName: HiveBoxes.generic,
    );
}
