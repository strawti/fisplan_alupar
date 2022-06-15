import 'dart:convert';

class UserResponseModel {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String phone;
  final bool phoneNumberVerified;
  final String status;
  final bool isConnected;
  final String? photo;
  final String role;
  final int? recordCountThisMonth;

  UserResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.phone,
    required this.phoneNumberVerified,
    required this.status,
    required this.isConnected,
    this.photo,
    required this.role,
    this.recordCountThisMonth,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'emailVerified': emailVerified});
    result.addAll({'phone': phone});
    result.addAll({'phoneNumberVerified': phoneNumberVerified});
    result.addAll({'status': status});
    result.addAll({'isConnected': isConnected});
    if(photo != null){
      result.addAll({'photo': photo});
    }
    result.addAll({'role': role});
    if(recordCountThisMonth != null){
      result.addAll({'recordCountThisMonth': recordCountThisMonth});
    }
  
    return result;
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      phone: map['phone'] ?? '',
      phoneNumberVerified: map['phoneNumberVerified'] ?? false,
      status: map['status'] ?? '',
      isConnected: map['isConnected'] ?? false,
      photo: map['photo'],
      role: map['role'] != null ? map['role']['name'] : '',
      recordCountThisMonth: map['recordCountThisMonth']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthResponseModel(id: $id, name: $name, email: $email, emailVerified: $emailVerified, phone: $phone, phoneNumberVerified: $phoneNumberVerified, status: $status, isConnected: $isConnected, photo: $photo, role: $role, recordCountThisMonth: $recordCountThisMonth)';
  }
}
