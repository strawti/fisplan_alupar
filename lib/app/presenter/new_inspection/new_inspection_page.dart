import 'package:flutter/material.dart';

import 'widgets/new_inspection_body.dart';

class NewInspectionPage extends StatelessWidget {
  const NewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/new-inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nova Inspeção")),
      body: const NewInspectionBody(),
    );
  }
}
