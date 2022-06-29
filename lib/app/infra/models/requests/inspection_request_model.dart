import 'dart:convert';

import 'package:fisplan_alupar/app/infra/models/responses/answer_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/audio_model.dart';

import '../responses/photo_model.dart';

class InspectionRequestModel {
  final int userId;
  final int activityId;
  final int projectId;
  final int? tensionLevelId;
  final int installationId;
  final int installationTypeId;
  final int? equipmentCategoryId;
  final int? towerId;
  final int? equipmentId;
  final int stepId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AudioModel> audios;
  final List<PhotoModel> photos;
  final List<AnswerModel> answers;
  final double progress;
  final String name;
  final String? description;

  // For Internal
  final bool isSendAudios;
  final bool isSendPhotos;
  final bool isSendAnswers;

  InspectionRequestModel(
    this.userId,
    this.activityId,
    this.projectId,
    this.tensionLevelId,
    this.installationId,
    this.installationTypeId,
    this.equipmentCategoryId,
    this.towerId,
    this.equipmentId,
    this.stepId,
    this.createdAt,
    this.updatedAt,
    this.audios,
    this.photos,
    this.answers,
    this.progress,
    this.name,
    this.description, {
    this.isSendAudios = false,
    this.isSendPhotos = false,
    this.isSendAnswers = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': userId});
    result.addAll({'activity_id': activityId});
    result.addAll({'project_id': projectId});
    if (tensionLevelId != null) {
      result.addAll({'tension_level_id': tensionLevelId});
    }
    result.addAll({'installation_id': installationId});
    result.addAll({'installation_type_id': installationTypeId});
    if (equipmentCategoryId != null) {
      result.addAll({'equipment_category_id': equipmentCategoryId});
    }
    if (towerId != null) {
      result.addAll({'tower_id': towerId});
    }
    if (equipmentId != null) {
      result.addAll({'equipment_id': equipmentId});
    }
    result.addAll({'step_id': stepId});
    result.addAll({'created_at': createdAt.millisecondsSinceEpoch});
    result.addAll({'updated_at': updatedAt.millisecondsSinceEpoch});
    result.addAll({'audios': audios.map((x) => x.toMap()).toList()});
    result.addAll({'photos': photos.map((x) => x.toMap()).toList()});
    result.addAll({'answers': answers.map((x) => x.toMap()).toList()});
    result.addAll({'progress': progress});
    result.addAll({'name': name});
    if (description != null) {
      result.addAll({'description': description});
    }

    return result;
  }

  factory InspectionRequestModel.fromMap(Map<String, dynamic> map) {
    return InspectionRequestModel(
      map['user_id']?.toInt() ?? 0,
      map['activity_id']?.toInt() ?? 0,
      map['project_id']?.toInt() ?? 0,
      map['tension_level_id']?.toInt(),
      map['installation_id']?.toInt() ?? 0,
      map['installation_type_id']?.toInt() ?? 0,
      map['equipment_category_id']?.toInt(),
      map['tower_id']?.toInt(),
      map['equipment_id']?.toInt(),
      map['step_id']?.toInt() ?? 0,
      DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      List<AudioModel>.from(map['audios']?.map((x) => AudioModel.fromMap(x))),
      List<PhotoModel>.from(map['photos']?.map((x) => PhotoModel.fromMap(x))),
      List<AnswerModel>.from(
          map['answers']?.map((x) => AnswerModel.fromMap(x))),
      map['progress']?.toInt() ?? 0,
      map['name'] ?? '',
      map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionRequestModel.fromJson(String source) =>
      InspectionRequestModel.fromMap(json.decode(source));
}
