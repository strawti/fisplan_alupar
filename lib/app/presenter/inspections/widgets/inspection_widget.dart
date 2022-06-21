import 'package:flutter/material.dart';

import '../../../infra/models/inspection_model.dart';
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
    );
  }
}


