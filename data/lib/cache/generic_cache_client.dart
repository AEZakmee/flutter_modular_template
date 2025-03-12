import 'package:hive/hive.dart';

abstract class GenericCacheClient<T> {
  GenericCacheClient({required CollectionBox<dynamic> box}) : _box = box;

  final CollectionBox<dynamic> _box;
  abstract String key;

  Future<T?> get() => _box.get(key).then((value) => value as T?);

  Future<void> put({required T data}) async {
    await _box.put(key, data);
  }

  Future<void> delete() async {
    await _box.delete(key);
  }
}
