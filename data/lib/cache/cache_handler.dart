import 'package:hive/hive.dart';

class CacheHandler {
  CacheHandler({required List<CollectionBox> boxes}) : _boxes = boxes;

  final List<CollectionBox> _boxes;

  Future<void> clearCache() async {
    for (final box in _boxes) {
      await box.clear();
    }
  }
}
