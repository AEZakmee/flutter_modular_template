import 'package:hive/hive.dart';

part 'answer_cache.g.dart';

@HiveType(typeId: 4)
class AnswerCache extends HiveObject {
  AnswerCache({
    required this.name,
    required this.years,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int years;
}
