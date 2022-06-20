class RecoveryPasswordRequestModel {
  final String email;

  RecoveryPasswordRequestModel({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});

    return result;
  }
}
