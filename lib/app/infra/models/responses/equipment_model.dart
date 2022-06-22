import 'dart:convert';

class EquipmentModel {
  final int id;
  final int installationId;
  final int equipmentCategoryId;
  final int? tensionLevelId;
  final String name;
  final String? description;
  final String? make;
  final String? model;

  EquipmentModel({
    required this.id,
    required this.installationId,
    required this.equipmentCategoryId,
    required this.tensionLevelId,
    required this.name,
    required this.description,
    required this.make,
    required this.model,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'installation_id': installationId});
    result.addAll({'equipment_category_id': equipmentCategoryId});
    result.addAll({'tension_level_id': tensionLevelId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'make': make});
    result.addAll({'model': model});

    return result;
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      id: map['id'],
      installationId: map['installation_id'],
      equipmentCategoryId: map['equipment_category_id'],
      tensionLevelId: map['tension_level_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      make: map['make'] ?? '',
      model: map['model'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentModel.fromJson(String source) =>
      EquipmentModel.fromMap(json.decode(source));
}
