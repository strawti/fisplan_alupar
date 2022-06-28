import 'package:flutter/material.dart';

class InspectionTitleAndContentWidget extends StatelessWidget {
  const InspectionTitleAndContentWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
