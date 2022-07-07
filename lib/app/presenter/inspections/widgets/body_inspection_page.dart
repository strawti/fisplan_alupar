import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/search_widget.dart';
import '../inspections_controller.dart';
import 'inspections_widget.dart';

class BodyInspectionPage extends StatelessWidget {
  const BodyInspectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            Get.find<InspectionsController>().routeArguments!.project.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SearchWidget<InspectionsController>(
          controller: Get.find<InspectionsController>().searchController,
        ),
        const InspectionsWidget(),
      ],
    );
  }
}
