import 'package:fisplan_alupar/app/core/app_validators.dart';
import 'package:fisplan_alupar/app/presenter/auth/login/login_controller.dart';
import 'package:fisplan_alupar/app/shared/widgets/button_default_widget.dart';
import 'package:fisplan_alupar/app/shared/widgets/textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_assets.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(appAssetLogo, width: 200),
        const SizedBox(height: 30),
        GetBuilder<LoginController>(
          builder: (control) {
            return TextFormWidget(
              controller: control.emailController,
              enabled: control.isLoading == false,
              labelText: 'Email',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            );
          },
        ),
        const SizedBox(height: 10),
        GetBuilder<LoginController>(
          builder: (control) {
            return TextFormWidget(
              controller: control.passwordController,
              enabled: control.isLoading == false,
              labelText: 'Senha',
              textInputAction: TextInputAction.done,
              validator: simpleValidate,
            );
          },
        ),
        const SizedBox(height: 30),
        GetBuilder<LoginController>(
          builder: (control) {
            return ButtonDefaultWidget(
              title: 'ENTRAR',
              onTap: control.login,
              isLoading: control.isLoading,
              enabled: control.isValidForm,
            );
          },
        ),
      ],
    );
  }
}
