import 'package:data/cache/cache_handler.dart';
import 'package:data/cache/settings/locale_cache_client.dart';
import 'package:data/cache/settings/theme_type_cache_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/hive_boxes.dart';
import '../locator.dart';

void cache() {
  locator
    ..registerLazySingleton(FlutterSecureStorage.new)
    ..registerLazySingleton(
      () => ThemeTypeCacheClient(box: locator(instanceName: HiveBoxes.generic)),
    )
    ..registerLazySingleton(
      () => LocaleCacheClient(box: locator(instanceName: HiveBoxes.generic)),
    )
    ..registerLazySingleton(
      () => CacheHandler(boxes: [locator(instanceName: HiveBoxes.generic)]),
    );
}
