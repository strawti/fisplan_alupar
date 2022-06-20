import 'dart:convert';

class TowerModel {
  final int id;
  final int installationId;
  final int towerTypeId;
  final String name;
  final String? description;
  final String span;
  final int spanLength;
  final int lat;
  final int long;
  final int height;
  final TowerTypeModel towerType;
  
  TowerModel({
    required this.id,
    required this.installationId,
    required this.towerTypeId,
    required this.name,
    required this.description,
    required this.span,
    required this.spanLength,
    required this.lat,
    required this.long,
    required this.height,
    required this.towerType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'installation_id': installationId});
    result.addAll({'tower_type_id': towerTypeId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'span': span});
    result.addAll({'span_length': spanLength});
    result.addAll({'lat': lat});
    result.addAll({'long': long});
    result.addAll({'height': height});
    result.addAll({'tower_type': towerType.toMap()});
  
    return result;
  }

  factory TowerModel.fromMap(Map<String, dynamic> map) {
    return TowerModel(
      id: map['id']?.toInt() ?? 0,
      installationId: map['installation_id']?.toInt() ?? 0,
      towerTypeId: map['tower_type_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      span: map['span'] ?? '',
      spanLength: map['span_length']?.toInt() ?? 0,
      lat: map['lat']?.toInt() ?? 0,
      long: map['long']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      towerType: TowerTypeModel.fromMap(map['tower_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TowerModel.fromJson(String source) => TowerModel.fromMap(json.decode(source));
}

class TowerTypeModel {
  final int id;
  final String name;
  TowerTypeModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
  
    return result;
  }

  factory TowerTypeModel.fromMap(Map<String, dynamic> map) {
    return TowerTypeModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TowerTypeModel.fromJson(String source) => TowerTypeModel.fromMap(json.decode(source));
}