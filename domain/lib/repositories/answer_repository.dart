import '../model/answer/answer.dart';

abstract interface class AnswerRepository {
  Future<void> clearAnswers();
  Future<void> cacheAnswer(Answer answer);
  Stream<List<Answer>> observeAnswers();
}
