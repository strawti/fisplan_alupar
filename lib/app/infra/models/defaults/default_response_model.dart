import 'dart:convert';

import 'default_error_model.dart';

class DefaultResponseModel {
  final bool success;
  final dynamic data;
  final DefaultErrorModel? error;
  final dynamic metadata;

  DefaultResponseModel({
    required this.success,
    this.data,
    required this.error,
    required this.metadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
      'error': error?.toMap(),
    };
  }

  factory DefaultResponseModel.fromMap(Map<String, dynamic>? map) {
    return DefaultResponseModel(
      success: map?['success'] ?? false,
      data: map?['data'],
      error: map?['error'] != null
          ? DefaultErrorModel.fromMap(map?['error'])
          : null,
      metadata: map?['metadata'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultResponseModel.fromJson(String source) =>
      DefaultResponseModel.fromMap(json.decode(source));
}
