import 'dart:convert';

class EquipmentCategoryModel {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  EquipmentCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory EquipmentCategoryModel.fromMap(Map<String, dynamic> map) {
    return EquipmentCategoryModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentCategoryModel.fromJson(String source) =>
      EquipmentCategoryModel.fromMap(json.decode(source));
}
