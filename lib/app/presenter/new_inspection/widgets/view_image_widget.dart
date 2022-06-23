import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewImageWidget extends StatelessWidget {
  final File image;

  const ViewImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Imagem')),
      body: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: Image.file(
              image,
              fit: BoxFit.fill,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(
              child: Hero(
                tag: image.path,
                child: InteractiveViewer(
                  child: Image.file(image),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
