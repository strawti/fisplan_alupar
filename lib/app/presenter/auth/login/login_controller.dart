import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_token.dart';
import '../../../core/app_validators.dart';
import '../../../infra/models/requests/auth/login_request_model.dart';
import '../../../infra/providers/auth/login_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';
import '../../home/home_page.dart';

class LoginController extends GetxController with LoaderManager {
  final LoginProvider _loginProvider;
  LoginController(this._loginProvider);

  @override
  void onReady() {
    super.onReady();

    emailController.addListener(update);
    passwordController.addListener(update);

    Future.delayed(const Duration(seconds: 1)).then((value) {
      emailController.text = 'fiscal1@alupar.com.br';
      passwordController.text = '123456';
    });
  }

  @override
  void onClose() {
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }

  final emailController = TextEditingController();
  String get email => emailController.text.trim();

  final passwordController = TextEditingController();
  String get password => passwordController.text.trim();

  Future login() async {
    setIsLoading(true);

    final response = await _loginProvider.signIn(LoginRequestModel(
      email: email,
      password: password,
    ));

    if (response.isSuccess) {
      await AppToken.instance.setToken(response.data);
      Get.offAllNamed(HomePage.route);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }

    setIsLoading(false);
  }

  bool get isValidForm {
    return validateEmail(email) == null && simpleValidate(password) == null;
  }
}
