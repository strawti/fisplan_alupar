import 'dart:convert';

class UserResponseModel {
  final int id;
  final String name;
  final String email;
  final int companyId;

  UserResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.companyId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'company_id': companyId});

    return result;
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      companyId: map['company_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));
}
