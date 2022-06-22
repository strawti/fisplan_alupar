import 'widgets/new_inspection_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_inspection_controller.dart';

class NewInspectionPage extends GetView<NewInspectionController> {
  const NewInspectionPage({Key? key}) : super(key: key);

  static const String route = '/new-inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewInspectionPage'),
      ),
      body: NewInspectionBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Atualizar dados'),
      ),
    );
  }
}
