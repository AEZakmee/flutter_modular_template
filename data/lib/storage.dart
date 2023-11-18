import 'dart:convert';
import 'dart:developer';

import 'package:core/utils/extensions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'datasource/cache/models/answer_cache.dart';
import 'datasource/cache/models/settings_cache.dart';
import 'datasource/cache/models/theme_type_cache.dart';
import 'datasource/cache/models/user_tokens_cache.dart';
import 'datasource/const/storage_consts.dart';

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);

Future<void> setupStorage() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserTokensCacheAdapter())
    ..registerAdapter(SettingsCacheAdapter())
    ..registerAdapter(ThemeTypeCacheAdapter())
    ..registerAdapter(AnswerCacheAdapter());

  const secureStorage = FlutterSecureStorage();
  String? key;

  try {
    key = await secureStorage.read(
      key: StorageConsts.hiveEncryptionKey,
      aOptions: _getAndroidOptions(),
    );
  } on Exception catch (e) {
    await secureStorage.deleteAll();
    log('Problem with reading secure storage key: $e');
  }

  if (key == null) {
    final generatedKey = Hive.generateSecureKey();
    await secureStorage.write(
      key: StorageConsts.hiveEncryptionKey,
      value: base64UrlEncode(generatedKey),
      aOptions: _getAndroidOptions(),
    );
    key = await secureStorage.read(
      key: StorageConsts.hiveEncryptionKey,
      aOptions: _getAndroidOptions(),
    );
  }

  //Generic boxes
  await key?.let((key) async {
    final encryptionKey = base64Url.decode(key);
    await Hive.openBox(
      StorageConsts.hiveEncryptedStorageKey,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  });

  await Hive.openBox(StorageConsts.hiveStorageKey);

  //Specific boxes
  await Hive.openBox<AnswerCache>(StorageConsts.hiveAnswerStorageKey);
}
