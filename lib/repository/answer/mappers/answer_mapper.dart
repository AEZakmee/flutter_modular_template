import '../../../app/model/answer/answer.dart';
import '../../../datasource/cache/models/answer_cache.dart';

extension AnswerCacheMapper on AnswerCache {
  Answer toDomain() => Answer(
        id: id,
        name: name,
        years: years,
      );
}

extension AnswerMapper on Answer {
  AnswerCache toCache() => AnswerCache(
        id: id,
        name: name,
        years: years,
      );
}
