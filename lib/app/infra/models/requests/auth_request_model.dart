class AuthRequestModel {
  String email;
  String password;

  AuthRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }
}
