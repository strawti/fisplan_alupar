import 'dart:convert';

class TensionLevelModel {
  final int id;
  final int projectId;
  final String name;
  final String? description;

  TensionLevelModel({
    required this.id,
    required this.projectId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'project_id': projectId});
    result.addAll({'name': name});
    result.addAll({'description': description});

    return result;
  }

  factory TensionLevelModel.fromMap(Map<String, dynamic> map) {
    return TensionLevelModel(
      id: map['id']?.toInt() ?? 0,
      projectId: map['project_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TensionLevelModel.fromJson(String source) =>
      TensionLevelModel.fromMap(json.decode(source));
}
