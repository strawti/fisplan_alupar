import 'dart:convert';

import 'package:fisplan_alupar/app/infra/models/answer_model.dart';
import 'package:fisplan_alupar/app/infra/models/audio_model.dart';
import 'package:fisplan_alupar/app/infra/models/photo_model.dart';

class InspectionModel {
  final int id;
  final int userId;
  final int activityId;
  final int projectId;
  final int? tensionLevelId;
  final int installationId;
  final int installationTypeId;
  final int? equipmentCategoryId;
  final int? towerId;
  final int? equipmentId;
  final int? stepId;
  final String name;
  final String? description;
  final int? latitude;
  final int? longitude;
  final String? comments;
  final String date;
  final String createdAt;
  final String updatedAt;
  final List<PhotoModel>? photos;
  final List<AudioModel>? audios;
  final List<AnswerModel>? answers;
  final int progress;

  InspectionModel({
    required this.id,
    required this.userId,
    required this.activityId,
    required this.projectId,
    required this.tensionLevelId,
    required this.installationId,
    required this.installationTypeId,
    required this.equipmentCategoryId,
    required this.towerId,
    required this.equipmentId,
    required this.stepId,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.comments,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.photos,
    required this.audios,
    required this.answers,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'user_id': userId});
    result.addAll({'activity_id': activityId});
    result.addAll({'project_id': projectId});
    result.addAll({'tension_level_id': tensionLevelId});
    result.addAll({'installation_id': installationId});
    result.addAll({'installation_type_id': installationTypeId});
    result.addAll({'equipment_category_id': equipmentCategoryId});
    result.addAll({'tower_id': towerId});
    result.addAll({'equipment_id': equipmentId});
    result.addAll({'step_id': stepId});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'comments': comments});
    result.addAll({'date': date});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'photos': photos?.map((x) => x.toMap()).toList()});
    result.addAll({'audios': audios?.map((x) => x.toMap()).toList()});
    result.addAll({'answers': answers?.map((x) => x.toMap()).toList()});
    result.addAll({'progress': progress});

    return result;
  }

  factory InspectionModel.fromMap(Map<String, dynamic> map) {
    return InspectionModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      activityId: map['activity_id']?.toInt() ?? 0,
      projectId: map['project_id']?.toInt() ?? 0,
      tensionLevelId: map['tension_level_id']?.toInt() ?? 0,
      installationId: map['installation_id']?.toInt() ?? 0,
      installationTypeId: map['installation_type_id']?.toInt() ?? 0,
      equipmentCategoryId: map['equipment_category_id']?.toInt() ?? 0,
      towerId: map['tower_id']?.toInt() ?? 0,
      equipmentId: map['equipment_id']?.toInt() ?? 0,
      stepId: map['step_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      latitude: map['latitude']?.toInt() ?? 0,
      longitude: map['longitude']?.toInt() ?? 0,
      comments: map['comments'] ?? '',
      date: map['date'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      photos: map['photos'] != null
          ? List<PhotoModel>.from(
              map['photos']?.map((x) => PhotoModel.fromMap(x)))
          : null,
      audios: map['audios'] != null
          ? List<AudioModel>.from(
              map['audios']?.map((x) => AudioModel.fromMap(x)))
          : null,
      answers: map['answers'] != null
          ? List<AnswerModel>.from(
              map['answers']?.map((x) => AnswerModel.fromMap(x)))
          : null,
      progress: map['progress']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionModel.fromJson(String source) =>
      InspectionModel.fromMap(json.decode(source));
}
