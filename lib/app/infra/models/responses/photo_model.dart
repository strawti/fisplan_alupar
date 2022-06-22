import 'dart:convert';

class PhotoModel {
  final String path;
  PhotoModel({
    required this.path,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'path': path});
  
    return result;
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      path: map['path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String source) => PhotoModel.fromMap(json.decode(source));
}