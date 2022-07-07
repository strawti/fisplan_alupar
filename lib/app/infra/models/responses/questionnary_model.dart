import 'dart:convert';

import '../../enums/question_types_enum.dart';

class QuestionnaryModel {
  final int id;
  final int projectId;
  final String name;
  final String? description;

  final List<Question> questions;
  QuestionnaryModel({
    required this.id,
    required this.projectId,
    required this.name,
    required this.description,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'project_id': projectId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'questions': questions.map((x) => x.toMap()).toList()});

    return result;
  }

  factory QuestionnaryModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaryModel(
      id: map['id'],
      projectId: map['project_id'],
      name: map['name'] ?? '',
      description: map['description'],
      questions: List<Question>.from(
        map['questions']?.map(
          (x) => Question.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionnaryModel.fromJson(String source) =>
      QuestionnaryModel.fromMap(json.decode(source));
}

class Question {
  final int id;
  final String? name;
  final String description;
  final bool isActive;
  final bool isRequired;
  final int questionnaireId;
  final int questionTypeId;
  final int? equipmentCategoryId;
  final int stepId;
  final int activityId;
  final List<AlternativeModel> alternatives;

  QuestionTypesEnum get questionType {
    return QuestionTypesEnum.values[questionTypeId - 1];
  }

  Question({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.isRequired,
    required this.questionnaireId,
    required this.questionTypeId,
    required this.equipmentCategoryId,
    required this.stepId,
    required this.activityId,
    required this.alternatives,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'is_active': isActive});
    result.addAll({'is_required': isRequired});
    result.addAll({'questionnaire_id': questionnaireId});
    result.addAll({'question_type_id': questionTypeId});
    result.addAll({'equipment_category_id': equipmentCategoryId});
    result.addAll({'step_id': stepId});
    result.addAll({'activity_id': activityId});
    result.addAll({'alternatives': alternatives});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      isActive: map['is_active'] ?? false,
      isRequired: map['is_required'] ?? false,
      questionnaireId: map['questionnaire_id'],
      questionTypeId: map['question_type_id'],
      equipmentCategoryId: map['equipment_category_id'],
      stepId: map['step_id'],
      activityId: map['activity_id'],
      alternatives: List<AlternativeModel>.from(
        map['alternatives']?.map(
          (x) {
            return x is Map
                ? AlternativeModel.fromMap(x as Map<String, dynamic>)
                : AlternativeModel.fromJson(x);
          },
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  Question copyWith({
    int? id,
    String? name,
    String? description,
    bool? isActive,
    bool? isRequired,
    int? questionnaireId,
    int? questionTypeId,
    int? equipmentCategoryId,
    int? stepId,
    int? activityId,
    List<AlternativeModel>? alternatives,
  }) {
    return Question(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isRequired: isRequired ?? this.isRequired,
      questionnaireId: questionnaireId ?? this.questionnaireId,
      questionTypeId: questionTypeId ?? this.questionTypeId,
      equipmentCategoryId: equipmentCategoryId ?? this.equipmentCategoryId,
      stepId: stepId ?? this.stepId,
      activityId: activityId ?? this.activityId,
      alternatives: alternatives ?? this.alternatives,
    );
  }
}

class AlternativeModel {
  final int id;
  final String description;
  final int questionId;
  AlternativeModel({
    required this.id,
    required this.description,
    required this.questionId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'description': description});
    result.addAll({'question_id': questionId});

    return result;
  }

  factory AlternativeModel.fromMap(Map<String, dynamic> map) {
    return AlternativeModel(
      id: map['id'],
      description: map['description'] ?? '',
      questionId: map['question_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AlternativeModel.fromJson(String source) =>
      AlternativeModel.fromMap(json.decode(source));
}
