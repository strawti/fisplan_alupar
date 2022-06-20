import 'dart:convert';

class TowerModel {
  final int id;
  final int installationId;
  final int towerTypeId;
  final String name;
  final String? description;
  final String span;
  final double spanLength;
  final double lat;
  final double long;
  final double height;
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
      id: map['id'],
      installationId: map['installation_id'],
      towerTypeId: map['tower_type_id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      span: map['span'] ?? '',
      spanLength: double.tryParse("${map['span_length']}") ?? 0.0,
      lat: double.tryParse("${map['lat']}") ?? 0.0,
      long: double.tryParse("${map['long']}") ?? 0.0,
      height: double.tryParse("${map['height']}") ?? 0,
      towerType: TowerTypeModel.fromMap(map['tower_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TowerModel.fromJson(String source) =>
      TowerModel.fromMap(json.decode(source));
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
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TowerTypeModel.fromJson(String source) =>
      TowerTypeModel.fromMap(json.decode(source));
}
