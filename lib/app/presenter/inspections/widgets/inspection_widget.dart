import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/models/responses/inspection_model.dart';
import '../../../routes/arguments/datails_inspection_page_arguments.dart';
import '../../details_inspection/details_inspection_page.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            DetailsInspectionPage.route,
            arguments: DetailsInspectionPageArguments(
              inspection,
              Get.find<InspectionsController>().routeArguments!.project,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 8,
              height: 120,
              color: inspection.getColor,
            ),
            Expanded(
              child: InspectionContentWidget(
                inspection: inspection,
              ),
            ),
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
