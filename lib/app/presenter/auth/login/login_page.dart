import 'package:fisplan_alupar/app/presenter/auth/login/widgets/login_body.dart';
import 'package:fisplan_alupar/app/shared/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: const BaseWidget(
        child: LoginBody(),
      ),
    );
  }
}
