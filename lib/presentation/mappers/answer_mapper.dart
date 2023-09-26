import '../../app/model/answer/answer.dart';
import '../model/answer_ui.dart';

extension AnswerUIMapper on Answer {
  AnswerUI toUI() => AnswerUI(
        name: name,
        years: years.toString(),
      );
}
