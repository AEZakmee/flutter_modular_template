import 'package:hive/hive.dart';

class CacheHandler {
  CacheHandler({
    required List<Box> boxes,
  }) : _boxes = boxes;

  final List<Box> _boxes;

  Future<void> clearCache() async {
    for (final box in _boxes) {
      await box.clear();
    }
  }
}
