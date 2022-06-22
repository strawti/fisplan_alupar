import 'dart:convert';

class ProjectModel {
  final int id;
  final int companyId;
  final String name;
  final String? description;
  final double progress;

  ProjectModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.description,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'company_id': companyId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'progress': progress});

    return result;
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      companyId: map['company_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      progress: double.tryParse("${map['progress']}") ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source));
}
