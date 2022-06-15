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

String? validateCPF(String? value) {
  if (simpleValidate(value) == null) {
    if (GetUtils.isCpf(value!)) {
      return null;
    } else {
      return 'O CPF informado é inválido';
    }
  } else {
    return simpleValidate(value);
  }
}

String? validatePhone(String value) {
  if (simpleValidate(value) == null) {
    if (GetUtils.isPhoneNumber(value)) {
      return null;
    } else {
      return 'O Número informado é inválido';
    }
  } else {
    return simpleValidate(value);
  }
}

String? validatePassword(String? value) {
  if (simpleValidate(value) == null) {
    if (value!.length <= 8) {
      return "A senha deve ter no mínimo 8 caracteres";
    }
  }

  return null;
}

String? validatePasswordConfirmation(String? value, String? valueConfirmation) {
  if (value != valueConfirmation) {
    return 'As senhas não conferem';
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

String? validateBirth(String? value) {
  if (simpleValidate(value) == null) {
    if (value!.length == 10) {
      return null;
    } else {
      return 'A data de nascimento informada é inválida';
    }
  } else {
    return simpleValidate(value);
  }
}

String? validateEnrollment(String? value) {
  if (simpleValidate(value) == null) {
  } else {
    return simpleValidate(value);
  }
  return null;
}
