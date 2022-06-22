import 'dart:convert';

import 'answer_model.dart';
import 'audio_model.dart';
import 'photo_model.dart';
import 'package:flutter/material.dart';

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
  final String equipmentName;
  final String? towerName;
  final int? equipmentId;
  final int? stepId;
  final String name;
  final String? description;
  final double? latitude;
  final double? longitude;
  final String? comments;
  final String date;
  final String createdAt;
  final String updatedAt;
  final String stepName;
  final List<PhotoModel>? photos;
  final List<AudioModel>? audios;
  final List<AnswerModel>? answers;
  final double progress;
  final String activityName;

  InspectionModel({
    required this.id,
    required this.userId,
    required this.equipmentName,
    required this.activityId,
    required this.projectId,
    required this.tensionLevelId,
    required this.installationId,
    required this.installationTypeId,
    required this.equipmentCategoryId,
    required this.towerId,
    required this.equipmentId,
    required this.stepId,
    required this.stepName,
    required this.name,
    required this.description,
    required this.towerName,
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
    required this.activityName,
  });

  String get getProgress {
    return '${progress.toStringAsFixed(0)}%';
  }

  Color get getColor {
    if (progress == 100) {
      return Colors.green;
    } else if (progress == 0) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

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
    result.addAll({'tower_name': towerName});
    result.addAll({'step_name': stepName});
    result.addAll({'equipment_name': equipmentName});
    result.addAll({'activity_name': activityName});

    return result;
  }

  factory InspectionModel.fromMap(Map<String, dynamic> map) {
    return InspectionModel(
      stepName: map['step_name'],
      towerName: map['tower_name'],
      equipmentName: map['equipment_name'],
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
      latitude: double.tryParse("${map['latitude']}") ?? 0.0,
      longitude: double.tryParse("${map['longitude']}") ?? 0.0,
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
      progress: double.tryParse("${map['progress']}") ?? 0.0,
      activityName: map['activity_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionModel.fromJson(String source) =>
      InspectionModel.fromMap(json.decode(source));
}
