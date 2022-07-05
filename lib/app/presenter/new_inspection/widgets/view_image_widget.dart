import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_token.dart';

class ViewImageWidget extends StatelessWidget {
  final dynamic image;

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
            child: image is File
                ? Image.file(
                    image,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    image,
                    fit: BoxFit.fill,
                    headers: {
                      'Authorization': 'Bearer ${AppToken.instance.token}',
                    },
                  ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(
              child: Hero(
                tag: image is File ? image.path : image,
                child: InteractiveViewer(
                  child: image is File
                      ? Image.file(image)
                      : Image.network(
                          image,
                          headers: {
                            'Authorization':
                                'Bearer ${AppToken.instance.token}',
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
