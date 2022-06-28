import 'dart:convert';

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
      id: map['id']?.toInt() ?? 0,
      projectId: map['project_id']?.toInt() ?? 0,
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
      id: map['id']?.toInt() ?? 0,
      name: map['name'],
      description: map['description'] ?? '',
      isActive: map['is_active'] ?? false,
      isRequired: map['is_required'] ?? false,
      questionnaireId: map['questionnaire_id']?.toInt() ?? 0,
      questionTypeId: map['question_type_id']?.toInt() ?? 0,
      equipmentCategoryId: map['equipment_category_id'],
      stepId: map['step_id']?.toInt() ?? 0,
      activityId: map['activity_id']?.toInt() ?? 0,
      alternatives: List<AlternativeModel>.from(
        map['alternatives']?.map(
          (x) => AlternativeModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
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
      id: map['id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      questionId: map['question_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlternativeModel.fromJson(String source) =>
      AlternativeModel.fromMap(json.decode(source));
}
