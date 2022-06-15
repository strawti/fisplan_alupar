class ConfirmCodeRequestModel {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;

  ConfirmCodeRequestModel({
    required this.email,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'code': code});
    result.addAll({'password': password});
    result.addAll({'confirm_password': confirmPassword});

    return result;
  }
}
