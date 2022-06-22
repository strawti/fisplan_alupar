import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './view_inspection_controller.dart';

class ViewInspectionPage extends GetView<ViewInspectionController> {
  const ViewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/view-inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Inspeção'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Você está visualizando a inspeção ',
                  ),
                  Text(
                    controller.arguments.inspection.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    ' do projeto:',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                controller.arguments.project.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
