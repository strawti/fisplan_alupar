import 'dart:convert';

class InstallationModel {
  final int id;
  final int projectId;
  final int installationTypeId;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  InstallationModel({
    required this.id,
    required this.projectId,
    required this.installationTypeId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'project_id': projectId});
    result.addAll({'installation_type_id': installationTypeId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory InstallationModel.fromMap(Map<String, dynamic> map) {
    return InstallationModel(
      id: map['id']?.toInt() ?? 0,
      projectId: map['project_id']?.toInt() ?? 0,
      installationTypeId: map['installation_type_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InstallationModel.fromJson(String source) =>
      InstallationModel.fromMap(json.decode(source));
}
