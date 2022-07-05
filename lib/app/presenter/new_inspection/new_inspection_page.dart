import 'package:fisplan_alupar/app/presenter/new_inspection/new_inspection_controller.dart';
import 'package:flutter/material.dart';

import 'widgets/new_inspection_body.dart';

class NewInspectionPage extends StatelessWidget {
  const NewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/new-inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NewInspectionController.to.arguments.inspectionRequest != null
            ? const Text("Edição de Inspeção")
            : const Text("Nova Inspeção"),
      ),
      body: const NewInspectionBody(),
    );
  }
}
