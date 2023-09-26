import 'package:hive/hive.dart';

abstract class GenericCacheClient<T> {
  GenericCacheClient({
    required Box<dynamic> box,
  }) : _box = box;

  final Box<dynamic> _box;
  abstract String key;

  T? get() => _box.get(key) as T?;

  Future<void> save({
    required T data,
  }) async {
    await _box.put(key, data);
  }

  Future<void> delete() async {
    if (_box.containsKey(key)) {
      await _box.delete(key);
    }
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Stream<T?> observe() => _box.watch(key: key).map(
        (event) => event.value as T?,
      );
}
