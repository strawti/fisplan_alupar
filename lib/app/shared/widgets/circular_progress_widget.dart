import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}
