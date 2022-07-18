import 'dart:convert';

class AnswerModel {
  final int? questionnaireId;
  final int questionId;

  /// String | int
  final dynamic answer;

  AnswerModel({
    required this.questionnaireId,
    required this.questionId,
    required this.answer,
  });

  String get getAnswer {
    if (answer == "true") {
      return "Sim";
    } else if (answer == "false") {
      return "Não";
    }
    return "$answer";
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question_id': questionId});
    result.addAll({'answer': answer});
    result.addAll({'questionnaire_id': questionnaireId});

    return result;
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      questionId: map['question_id'],
      answer: "${map['answer']}",
      questionnaireId: map['questionnaire_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source));

  AnswerModel copyWith({
    int? questionnaireId,
    int? questionId,
    dynamic answer,
  }) {
    return AnswerModel(
      questionnaireId: questionnaireId ?? this.questionnaireId,
      questionId: questionId ?? this.questionId,
      answer: answer ?? this.answer,
    );
  }
}
