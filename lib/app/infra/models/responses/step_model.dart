import 'dart:convert';

class StepModel {
  final int id;
  final String name;
  final String? description;
  final int equipmentCategoryId;
  final int projectId;
  final int? installationTypeId;

  StepModel({
    required this.id,
    required this.name,
    required this.description,
    required this.equipmentCategoryId,
    required this.projectId,
    required this.installationTypeId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'equipment_category_id': equipmentCategoryId});
    result.addAll({'project_id': projectId});
    result.addAll({'installation_type_id': installationTypeId});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      equipmentCategoryId: map['equipment_category_id']?.toInt() ?? 0,
      projectId: map['project_id']?.toInt() ?? 0,
      installationTypeId: map['installation_type_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StepModel.fromJson(String source) =>
      StepModel.fromMap(json.decode(source));
}
