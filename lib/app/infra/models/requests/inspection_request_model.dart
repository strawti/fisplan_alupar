import 'dart:convert';

import 'package:fisplan_alupar/app/infra/models/responses/answer_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/audio_model.dart';

import '../responses/photo_model.dart';

class InspectionRequestModel {
  final int? id;
  final int userId;
  final int? activityId;
  final int projectId;
  final int? tensionLevelId;
  final int installationId;
  final int installationTypeId;
  final int? equipmentCategoryId;
  final int? towerId;
  final int? equipmentId;
  final int? stepId;
  final String createdAt;
  final String updatedAt;
  final String date;
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
  final bool isSendInspection;

  InspectionRequestModel(
    this.date,
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
    this.id,
    this.isSendAudios = false,
    this.isSendPhotos = false,
    this.isSendAnswers = false,
    this.isSendInspection = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    /// Usado apenas para o insert no banco de dados
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
    result.addAll({'created_at': createdAt.toString()});
    result.addAll({'updated_at': updatedAt.toString()});
    result.addAll({'audios': audios.map((x) => x.toMap()).toList()});
    result.addAll({'photos': photos.map((x) => x.toMap()).toList()});
    result.addAll({'answers': answers.map((x) => x.toMap()).toList()});
    result.addAll({'progress': progress});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'date': date});

    return result;
  }

  factory InspectionRequestModel.fromMap(Map<String, dynamic> map) {
    return InspectionRequestModel(
      map['date'],
      map['user_id'],
      map['activity_id'],
      map['project_id'],
      map['tension_level_id'],
      map['installation_id'],
      map['installation_type_id'],
      map['equipment_category_id'],
      map['tower_id'],
      map['equipment_id'],
      map['step_id'],
      map['created_at'],
      map['updated_at'],
      List<AudioModel>.from(map['audios']?.map((x) => AudioModel.fromMap(x))),
      List<PhotoModel>.from(map['photos']?.map((x) => PhotoModel.fromMap(x))),
      List<AnswerModel>.from(
          map['answers']?.map((x) => AnswerModel.fromMap(x))),
      map['progress'],
      map['name'] ?? '',
      map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionRequestModel.fromJson(String source) =>
      InspectionRequestModel.fromMap(json.decode(source));

  InspectionRequestModel copyWith({
    int? id,
    int? userId,
    int? activityId,
    int? projectId,
    int? tensionLevelId,
    int? installationId,
    int? installationTypeId,
    int? equipmentCategoryId,
    int? towerId,
    int? equipmentId,
    int? stepId,
    String? createdAt,
    String? updatedAt,
    String? date,
    List<AudioModel>? audios,
    List<PhotoModel>? photos,
    List<AnswerModel>? answers,
    double? progress,
    String? name,
    String? description,
    bool? isSendAudios,
    bool? isSendPhotos,
    bool? isSendAnswers,
    bool? isSendInspection,
  }) {
    return InspectionRequestModel(
      date ?? this.date,
      id: id,
      userId ?? this.userId,
      activityId ?? this.activityId,
      projectId ?? this.projectId,
      tensionLevelId ?? this.tensionLevelId,
      installationId ?? this.installationId,
      installationTypeId ?? this.installationTypeId,
      equipmentCategoryId ?? this.equipmentCategoryId,
      towerId ?? this.towerId,
      equipmentId ?? this.equipmentId,
      stepId ?? this.stepId,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      audios ?? this.audios,
      photos ?? this.photos,
      answers ?? this.answers,
      progress ?? this.progress,
      name ?? this.name,
      description ?? this.description,
      isSendAudios: isSendAudios ?? this.isSendAudios,
      isSendPhotos: isSendPhotos ?? this.isSendPhotos,
      isSendAnswers: isSendAnswers ?? this.isSendAnswers,
      isSendInspection: isSendInspection ?? this.isSendInspection,
    );
  }
}
