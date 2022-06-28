import 'package:fisplan_alupar/app/presenter/details_inspection/widgets/details_inspection_body.dart';
import 'package:flutter/material.dart';

class DetailsInspectionPage extends StatelessWidget {
  const DetailsInspectionPage({Key? key}) : super(key: key);
  static const String route = '/details_inspection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailsInspectionPage'),
      ),
      body: const DetailspectionBody(),
    );
  }
}
