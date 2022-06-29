import 'dart:convert';

class AnswerModel {
  final int questionnaireId;
  final int questionId;

  /// String | int
  final dynamic answer;

  AnswerModel({
    required this.questionnaireId,
    required this.questionId,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question_id': questionId});
    result.addAll({'answer': answer});
    result.addAll({'questionnaire_id': questionnaireId});

    return result;
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      questionId: map['question_id']?.toInt() ?? 0,
      answer: "${map['answer']}",
      questionnaireId: map['questionnaire_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source));
}
