import 'package:data/cache/answer/answer_cache_client.dart';
import 'package:data/cache/settings/settings_cache_client.dart';
import 'package:data/cache/user/user_tokens_cache_client.dart';
import 'package:data/constants/storage_consts.dart';
import 'package:hive/hive.dart';

import '../locator.dart';

void cache() {
  locator
    ..registerLazySingleton(
      () => UserTokensCacheClient(
        box: Hive.box(StorageConsts.hiveEncryptedStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => SettingsCacheClient(
        box: Hive.box(StorageConsts.hiveStorageKey),
      ),
    )
    ..registerLazySingleton(
      () => AnswerCacheClient(
        box: Hive.box(StorageConsts.hiveAnswerStorageKey),
      ),
    );
}
