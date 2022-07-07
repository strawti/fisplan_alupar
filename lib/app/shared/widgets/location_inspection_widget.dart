import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenter/new_inspection/widgets/new_inspection_card.dart';
import '../utils/get_datetime.dart';

class LocationInspectionWidget<T extends GetxController>
    extends StatelessWidget {
  /// GetxController
  final dynamic control;
  const LocationInspectionWidget({
    Key? key,
    required this.control,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Localização',
      child: Column(children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Latitude'),
            const SizedBox(width: 10),
            GetBuilder<T>(
              id: "position",
              builder: (_) {
                if (control.position == null) {
                  return const Text('Não informado');
                }

                return Text(control.position!.latitude.toString());
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.black12, thickness: 1),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Longitude'),
            const SizedBox(width: 10),
            GetBuilder<T>(
              id: "position",
              builder: (_) {
                if (control.position == null) {
                  return const Text('Não informado');
                }

                return Text(control.position!.longitude.toString());
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.black12, thickness: 1),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Data/Hora'),
            const SizedBox(width: 10),
            GetBuilder<T>(
              id: "position",
              builder: (_) {
                if (control.position == null) {
                  return const Text('Não informado');
                }

                return Text(
                  formatDateTimeForString(
                    control.position!.timestamp,
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
