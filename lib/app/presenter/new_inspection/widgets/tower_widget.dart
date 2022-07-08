import 'package:flutter/material.dart';

import '../../../infra/models/responses/tower_model.dart';
import '../../../shared/widgets/divider_widget.dart';

class TowerWidget extends StatelessWidget {
  final TowerModel tower;
  const TowerWidget({
    Key? key,
    required this.tower,
  }) : super(key: key);

  List<String> get titles {
    return [
      "Latitude: ",
      "Longitude: ",
      "Altura: ",
      "Vão: ",
      "Comprimento do Vão: ",
    ];
  }

  List<String> get contents {
    return [
      "${tower.lat}",
      "${tower.long}",
      "${tower.height}",
      (tower.span),
      "${tower.spanLength} metros",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              tower.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          ),
        ],
      ),
    );
  }
}
