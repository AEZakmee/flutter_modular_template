import 'package:domain/model/answer/answer.dart';
import 'package:domain/repositories/answer_repository.dart';

import '../../datasource/cache/answer/answer_cache_client.dart';
import 'mappers/answer_mapper.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  AnswerRepositoryImpl({required AnswerCacheClient answerCacheClient})
      : _answerCacheClient = answerCacheClient;

  final AnswerCacheClient _answerCacheClient;

  @override
  Future<void> clearAnswers() async {
    await _answerCacheClient.clear();
  }

  @override
  Future<void> cacheAnswer(Answer answer) async {
    await _answerCacheClient.put(
      id: answer.id,
      data: answer.toCache(),
    );
  }

  @override
  List<Answer> get entries =>
      _answerCacheClient.entries.map((answer) => answer.toDomain()).toList();

  @override
  Stream<List<Answer>> observeAnswers() => _answerCacheClient.observeAll().map(
        (data) => data.map((answer) => answer.toDomain()).toList(),
      );
}
