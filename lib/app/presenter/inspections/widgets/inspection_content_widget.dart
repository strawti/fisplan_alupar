import 'package:flutter/material.dart';

import '../../../infra/models/responses/inspection_model.dart';
import 'inspection_sub_content_widget.dart';

class InspectionContentWidget extends StatelessWidget {
  const InspectionContentWidget({
    Key? key,
    required this.inspection,
  }) : super(key: key);

  final InspectionModel inspection;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inspection.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            InspectionSubContentWidget(inspection: inspection),
            const SizedBox(height: 10),
            Text(
              inspection.description!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
