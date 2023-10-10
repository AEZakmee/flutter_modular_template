import '../../app/model/answer/answer.dart';
import '../../datasource/cache/answer/answer_cache_client.dart';
import 'mappers/answer_mapper.dart';

class AnswerRepository {
  AnswerRepository({required AnswerCacheClient answerCacheClient})
      : _answerCacheClient = answerCacheClient;

  final AnswerCacheClient _answerCacheClient;

  Future<void> clearAnswers() async {
    await _answerCacheClient.clear();
  }

  Future<void> cacheAnswer(Answer answer) async {
    await _answerCacheClient.put(
      id: answer.id,
      data: answer.toCache(),
    );
  }

  List<Answer> get entries =>
      _answerCacheClient.entries.map((answer) => answer.toDomain()).toList();

  Stream<List<Answer>> observeAnswers() => _answerCacheClient.observeAll().map(
        (data) => data.map((answer) => answer.toDomain()).toList(),
      );
}
