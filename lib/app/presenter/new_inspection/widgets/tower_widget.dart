import '../../../shared/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

import '../../../infra/models/responses/tower_model.dart';

class TowerWidget extends StatelessWidget {
  final TowerModel tower;
  const TowerWidget({
    Key? key,
    required this.tower,
  }) : super(key: key);

  List<String> get titles => [
        "Latitude: ",
        "Longitude: ",
        "Altura: ",
        "Vão: ",
        "Comprimento do Vão: ",
      ];

  List<String> get contents => [
        "${tower.lat}",
        "${tower.long}",
        "${tower.height}",
        (tower.span),
        "${tower.spanLength} metros",
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          titles.length,
          (index) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(titles[index]),
                    Text(
                      contents[index],
                      textScaleFactor: 1.1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const DividerWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
