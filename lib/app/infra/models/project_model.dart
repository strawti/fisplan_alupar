import 'dart:convert';

class ProjectModel {
  final String id;
  final int companyId;
  final String name;
  final String? description;
  final int budget;

  ProjectModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.description,
    required this.budget,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'company_id': companyId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'budget': budget});

    return result;
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] ?? '',
      companyId: map['company_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      budget: map['budget']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source));
}
