import '../../app/model/answer/answer.dart';
import '../../repository/answer/answer_repo.dart';

class AnswersService {
  AnswersService({
    required AnswerRepository answerRepository,
  }) : _answerRepository = answerRepository;

  final AnswerRepository _answerRepository;

  Future<void> clearAnswers() => _answerRepository.clearAnswers();

  Future<void> cacheAnswer(Answer answer) =>
      _answerRepository.cacheAnswer(answer);

  List<Answer> getAnswers() => _answerRepository.getAll();

  Stream<List<Answer>> observeAnswers() => _answerRepository.observeAnswers();
}
