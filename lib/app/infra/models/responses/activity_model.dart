import 'dart:convert';

class ActivityModel {
  final int id;
  final int stepId;
  final String name;
  final String? description;

  ActivityModel({
    required this.id,
    required this.stepId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'step_id': stepId});
    result.addAll({'name': name});
    result.addAll({'description': description});

    return result;
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id']?.toInt() ?? 0,
      stepId: map['step_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source));
}
