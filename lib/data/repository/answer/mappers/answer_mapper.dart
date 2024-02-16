import '../../../../domain/model/answer/answer.dart';
import '../../../cache/model/answer_cache.dart';

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
