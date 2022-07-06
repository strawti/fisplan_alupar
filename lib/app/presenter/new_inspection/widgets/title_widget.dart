import 'package:flutter/material.dart';

import '../new_inspection_controller.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: NewInspectionController.to.arguments.isItDuplication,
      replacement: const Text(
        'Você está criando uma nova inspeção para o projeto:',
      ),
      child: Column(
        children: [
          const Text(
            'Você está duplicando a inspeção ',
            textAlign: TextAlign.center,
          ),
          Text(
            getText(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            ' para o projeto:',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String getText() {
    return NewInspectionController.to.arguments.inspectionRequest?.name ?? '';
  }
}
