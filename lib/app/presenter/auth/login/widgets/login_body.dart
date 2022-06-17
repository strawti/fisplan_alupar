import 'package:fisplan_alupar/app/shared/widgets/textform_widget.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextFormWidget(
          labelText: 'Email',
        ),
        TextFormWidget(
          labelText: 'Senha',
        )
      ],
    );
  }
}
