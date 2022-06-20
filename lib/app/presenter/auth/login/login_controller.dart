import 'package:fisplan_alupar/app/core/app_validators.dart';
import 'package:fisplan_alupar/app/infra/models/requests/auth/login_request_model.dart';
import 'package:fisplan_alupar/app/infra/providers/auth/login_provider.dart';
import 'package:fisplan_alupar/app/presenter/home/home_page.dart';
import 'package:fisplan_alupar/app/shared/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_token.dart';
import '../../../shared/utils/loader_manager.dart';

class LoginController extends GetxController with LoaderManager {
  final LoginProvider _loginProvider;
  LoginController(this._loginProvider);

  @override
  void onReady() {
    super.onReady();

    emailController.addListener(update);
    passwordController.addListener(update);
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

  void verify() {
    if (validateEmail(email) != null) {
      CustomSnackbar.to.show('Informe um e-mail válido');
      return;
    }

    if (simpleValidate(password) != null) {
      CustomSnackbar.to.show('Informe uma senha válida');
      return;
    }

    login();
  }

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
}
