import 'package:hive/hive.dart';

abstract class CacheClient<T> {
  CacheClient({
    required Box<T> box,
  }) : _box = box;

  final Box<T> _box;

  List<T> getAll() => _box.values.toList();

  T? get(int index) => _box.getAt(index);

  Future<void> add({
    required T data,
  }) async {
    await _box.add(data);
  }

  Future<void> addAll({
    required List<T> data,
  }) async {
    await _box.addAll(data);
  }

  Future<void> delete(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Stream<List<T>> observeAll() => _box.watch().map((_) {
        return _box.values.toList();
      });
}
