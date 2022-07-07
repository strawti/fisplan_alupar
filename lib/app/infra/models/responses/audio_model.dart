import 'dart:convert';

class AudioModel {
  final String path;
  AudioModel({
    required this.path,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'path': path});
    return result;
  }

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      path: map['path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AudioModel.fromJson(String source) =>
      AudioModel.fromMap(json.decode(source));
}
