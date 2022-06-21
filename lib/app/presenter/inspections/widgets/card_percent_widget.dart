import 'package:flutter/material.dart';

class CardPercentWidget extends StatelessWidget {
  const CardPercentWidget({
    Key? key,
    required this.progress,
    required this.color,
  }) : super(key: key);

  final String progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        progress,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
