import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/images_controller.dart';
import 'new_inspection_card.dart';
import 'view_image_widget.dart';

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Fotos',
      icon: IconButton(
        onPressed: Get.find<ImagesController>().addImages,
        icon: const Icon(Icons.camera_alt),
        color: Colors.black54,
      ),
      child: GetBuilder<ImagesController>(builder: (control) {
        return Column(
          children: control.allImages.map(
            (image) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ViewImageWidget(
                            image: image,
                          ),
                        );
                      },
                      child: Hero(
                        tag: image.path,
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        image.path.split('/').last,
                        textScaleFactor: 0.9,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        control.removeImage(image);
                      },
                      child: const Text(
                        'Apagar',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        );
      }),
    );
  }
}
