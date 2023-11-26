import 'package:dependencies/exposer.dart';

import '../model/answer/answer.dart';
import '../repositories/answer_repository.dart';

class AnswersService {
  AnswersService({
    required AnswerRepository answerRepository,
  }) : _answerRepository = answerRepository;

  final AnswerRepository _answerRepository;

  Future<void> clearAnswers() => _answerRepository.clearAnswers();

  Future<String> cacheAnswer({
    required String name,
    required int years,
  }) async {
    final id = const Uuid().v4();

    await _answerRepository.cacheAnswer(
      Answer(id: id, name: name, years: years),
    );

    return id;
  }

  List<Answer> getAnswers() => _answerRepository.entries;

  Stream<List<Answer>> observeAnswers() => _answerRepository.observeAnswers();
}
