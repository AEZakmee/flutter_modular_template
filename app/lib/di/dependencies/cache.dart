import 'package:data/cache/cache_handler.dart';
import 'package:data/cache/cocktails/cocktails_cache_client.dart';
import 'package:data/cache/model/cocktails/cocktail_cache.dart';
import 'package:data/cache/settings/locale_cache_client.dart';
import 'package:data/cache/settings/theme_type_cache_client.dart';
import 'package:data/constants/storage_consts.dart';
import 'package:hive/hive.dart';

import '../locator.dart';

void cache() {
  locator
    ..registerLazySingleton(
      () => ThemeTypeCacheClient(
        //If encryption is needed, use StorageConsts.hiveEncryptedStorageKey
        box: Hive.box(StorageConsts.hiveStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => LocaleCacheClient(
        box: Hive.box(StorageConsts.hiveStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => CocktailsCacheClient(
        box: Hive.box(StorageConsts.hiveCocktailStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => CacheHandler(
        boxes: [
          Hive.box(StorageConsts.hiveEncryptedStorageKey),
          Hive.box(StorageConsts.hiveStorageKey),
          Hive.box<CocktailCache>(StorageConsts.hiveCocktailStorageKey),
        ],
      ),
    );
}
