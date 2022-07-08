import 'dart:convert';

import '../responses/answer_model.dart';
import '../responses/audio_model.dart';
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
  final String? comments;
  final double longitude;
  final double latitude;

  // For Internal
  final bool isSendPhotos;
  final bool isSendInspection;

  InspectionRequestModel({
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
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.audios,
    required this.photos,
    required this.answers,
    required this.progress,
    required this.name,
    required this.description,
    required this.comments,
    required this.longitude,
    required this.latitude,
    this.isSendPhotos = false,
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
    result.addAll({'comments': comments});
    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});

    result.addAll({'isSendPhotos': isSendPhotos});
    result.addAll({'isSendInspection': isSendInspection});

    return result;
  }

  factory InspectionRequestModel.fromMap(Map<String, dynamic> map) {
    return InspectionRequestModel(
      date: map['date'],
      userId: map['user_id'],
      activityId: map['activity_id'],
      projectId: map['project_id'],
      tensionLevelId: map['tension_level_id'],
      installationId: map['installation_id'],
      installationTypeId: map['installation_type_id'],
      equipmentCategoryId: map['equipment_category_id'],
      towerId: map['tower_id'],
      equipmentId: map['equipment_id'],
      stepId: map['step_id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      progress: map['progress'],
      name: map['name'] ?? '',
      description: map['description'],
      comments: map['comments'],
      isSendInspection: map['isSendInspection'] ?? false,
      isSendPhotos: map['isSendPhotos'] ?? false,
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      audios: List<AudioModel>.from(
        map['audios']?.map(
          (x) => AudioModel.fromMap(x),
        ),
      ),
      photos: List<PhotoModel>.from(
        map['photos']?.map(
          (x) => PhotoModel.fromMap(x),
        ),
      ),
      answers: List<AnswerModel>.from(
        map['answers']?.map(
          (x) => AnswerModel.fromMap(x),
        ),
      ),
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
    bool? isSendInspection,
    String? comments,
    double? latitude,
    double? longitude,
  }) {
    return InspectionRequestModel(
      date: date ?? this.date,
      id: id,
      userId: userId ?? this.userId,
      activityId: activityId ?? this.activityId,
      projectId: projectId ?? this.projectId,
      tensionLevelId: tensionLevelId ?? this.tensionLevelId,
      installationId: installationId ?? this.installationId,
      installationTypeId: installationTypeId ?? this.installationTypeId,
      equipmentCategoryId: equipmentCategoryId ?? this.equipmentCategoryId,
      towerId: towerId ?? this.towerId,
      equipmentId: equipmentId ?? this.equipmentId,
      stepId: stepId ?? this.stepId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      audios: audios ?? this.audios,
      photos: photos ?? this.photos,
      answers: answers ?? this.answers,
      progress: progress ?? this.progress,
      name: name ?? this.name,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      isSendPhotos: isSendPhotos ?? this.isSendPhotos,
      isSendInspection: isSendInspection ?? this.isSendInspection,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
