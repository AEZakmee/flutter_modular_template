import 'package:hive/hive.dart';

part 'answer_cache.g.dart';

@HiveType(typeId: 4)
class AnswerCache extends HiveObject {
  AnswerCache({
    required this.id,
    required this.name,
    required this.years,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int years;
}
