import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: LayoutBuilder(builder: (contex, constraints) {
      return Container(
        padding: const EdgeInsets.all(0),
        width: constraints.maxWidth,
        child: child,
      );
    }));
  }
}
