import 'dart:convert';

class AnswerModel {
  final int questionId;
  final String answer;
  
  AnswerModel({
    required this.questionId,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'question_id': questionId});
    result.addAll({'answer': answer});
  
    return result;
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      questionId: map['question_id']?.toInt() ?? 0,
      answer: "${map['answer']}",
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source));
}