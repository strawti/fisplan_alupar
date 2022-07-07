import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'selection_controller.dart';
import 'widgets/body_selection_page.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key? key}) : super(key: key);

  static const route = '/selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.find<SelectionController>().routeArguments.title),
      ),
      body: const BodySelectionPage(),
    );
  }
}
