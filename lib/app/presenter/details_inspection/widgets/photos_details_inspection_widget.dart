import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_token.dart';
import '../../new_inspection/widgets/new_inspection_card.dart';
import '../../new_inspection/widgets/view_image_widget.dart';
import '../details_inspection_controller.dart';

class PhotosDetailsInspectionWidget extends StatelessWidget {
  const PhotosDetailsInspectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewInspectionCard(
      title: 'Fotos',
      child: GetBuilder<DetailsInspectionController>(
        builder: (control) {
          return Wrap(
            children: control.inspection.photos!.map(
              (image) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ViewImageWidget(image: image.path));
                    },
                    child: Hero(
                      tag: image.path,
                      child: Image.network(
                        image.path,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                        headers: {
                          'Authorization': 'Bearer ${AppToken.instance.token}',
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress?.cumulativeBytesLoaded ==
                              loadingProgress?.expectedTotalBytes) {
                            return child;
                          }

                          return CircularProgressIndicator(
                            value: double.parse(
                              "${loadingProgress?.cumulativeBytesLoaded ?? 0.0}",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
