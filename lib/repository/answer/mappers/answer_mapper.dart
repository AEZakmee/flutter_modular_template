import '../../../app/model/answer/answer.dart';
import '../../../datasource/cache/models/answer_cache.dart';

extension AnswerCacheMapper on AnswerCache {
  Answer toDomain() => Answer(name: name, years: years);
}

extension AnswerMapper on Answer {
  AnswerCache toCache() => AnswerCache(name: name, years: years);
}
