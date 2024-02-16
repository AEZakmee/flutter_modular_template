import 'dart:convert';

import 'package:flutter/services.dart';

abstract class JsonAssetClient {
  abstract String path;

  Future<String> readString() async {
    return rootBundle.loadString(path);
  }

  Future<Map<String, dynamic>> readJson() async {
    return readString().then(
      (jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>,
    );
  }

  Future<List<Map<String, dynamic>>> readJsonList() async {
    final jsonStr = await readString();
    final decodedList = jsonDecode(jsonStr) as List<dynamic>;
    final mapList = decodedList.map((e) => e as Map<String, dynamic>).toList();
    return mapList;
  }
}
