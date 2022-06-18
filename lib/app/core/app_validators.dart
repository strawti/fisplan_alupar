import 'package:get/get.dart';

String? simpleValidate(String? value) {
  if (value == null) {
    return 'Campo obrigatório';
  }

  if (value.isEmpty) {
    return 'Campo não pode ser vazio';
  }

  return null;
}

String? validateEmail(String? value) {
  if (simpleValidate(value) == null) {
    if (GetUtils.isEmail(value!)) {
      return null;
    } else {
      return 'O Email informado é inválido';
    }
  } else {
    return simpleValidate(value);
  }
}
