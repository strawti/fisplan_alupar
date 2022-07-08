import 'package:flutter/material.dart';

import '../../../infra/models/requests/inspection_request_model.dart';
import '../../inspections/inspections_controller.dart';

class InspectionUnsynchronizedWidget extends StatelessWidget {
  final InspectionRequestModel inspection;
  final InspectionsController control;
  const InspectionUnsynchronizedWidget({
    Key? key,
    required this.inspection,
    required this.control,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text("Inspeção ${inspection.name} não foi sincronizada"),
          ),
          if (control.isLoading == false)
            IconButton(
              onPressed: () async {
                await control.syncInspections(inspection: inspection);
              },
              icon: const Icon(Icons.sync),
            ),
        ],
      ),
      subtitle: Column(
        children: [
          ListTile(
            title: const Text('Inspeção'),
            trailing: inspection.isSendInspection
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
          ),
          if (inspection.photos.isNotEmpty)
            ListTile(
              title: const Text('Imagens'),
              trailing: inspection.isSendPhotos
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
            ),
        ],
      ),
    );
  }
}
