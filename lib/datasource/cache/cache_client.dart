import 'package:hive/hive.dart';

abstract class CacheClient<T> {
  CacheClient({
    required Box<T> box,
  }) : _box = box;

  final Box<T> _box;

  List<T> get entries => _box.values.toList();

  T? get(String id) => _box.get(id);

  Future<void> put({
    required String id,
    required T data,
  }) =>
      _box.put(id, data);

  Future<void> putAll(Map<dynamic, T> entries) => _box.putAll(entries);

  Future<void> delete(String id) async {
    if (_box.containsKey(id)) {
      await _box.delete(id);
    }
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Stream<List<T>> observeAll() => _box.watch().map((_) {
        return _box.values.toList();
      });

  Stream<T?> observe(String id) => _box.watch(key: id).map((_) {
        return _box.get(id);
      });
}
