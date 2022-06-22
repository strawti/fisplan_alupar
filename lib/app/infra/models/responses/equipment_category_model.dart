import 'dart:convert';

class EquipmentCategoryModel {
  final int id;
  final String name;
  final String? description;
  final int installationId;

  EquipmentCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.installationId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});

    return result;
  }

  factory EquipmentCategoryModel.fromMap(Map<String, dynamic> map) {
    return EquipmentCategoryModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      installationId: map['installation_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentCategoryModel.fromJson(String source) =>
      EquipmentCategoryModel.fromMap(json.decode(source));
}
