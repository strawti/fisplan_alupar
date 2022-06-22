import 'package:flutter/material.dart';

import '../../../shared/widgets/base_widget.dart';
import 'widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BaseWidget(child: LoginBody()),
    );
  }
}
