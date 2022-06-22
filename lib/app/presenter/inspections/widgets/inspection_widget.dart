import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/models/responses/inspection_model.dart';
import '../../../routes/arguments/view_inspection_page_arguments.dart';
import '../../view_inspection/view_inspection_page.dart';
import '../inspections_controller.dart';
import 'card_percent_widget.dart';
import 'inspection_content_widget.dart';

class InspectionWidget extends StatelessWidget {
  const InspectionWidget({
    Key? key,
    required this.inspection,
  }) : super(key: key);

  final InspectionModel inspection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          ViewInspectionPage.route,
          arguments: ViewInspectionPageArguments(
            inspection,
            Get.find<InspectionsController>().routeArguments.project,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 120,
              color: inspection.getColor,
            ),
            InspectionContentWidget(inspection: inspection),
            CardPercentWidget(
              progress: inspection.getProgress,
              color: inspection.getColor,
            ),
          ],
        ),
      ),
    );
  }
}
