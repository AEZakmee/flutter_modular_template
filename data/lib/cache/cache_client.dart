import 'package:hive/hive.dart';

abstract class CacheClient<T> {
  CacheClient({required CollectionBox<T> box}) : _box = box;

  final CollectionBox<T> _box;
  Future<Map<String, T>> get entries => _box.getAllValues();
  Future<Iterable<String>> get keys => _box.getAllKeys();

  Future<bool> isEmpty() async {
    final allValues = await _box.getAllValues();
    return allValues.isEmpty;
  }

  Future<T?> get(String id) => _box.get(id);

  Future<void> put({required String id, required T data}) => _box.put(id, data);

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
