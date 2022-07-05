import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/widgets/alert_dialog_widget.dart';
import '../widgets/image_source_widget.dart';

class ImagesController extends GetxController {
  List<File> allImages = [];
  Future addImages() async {
    final ImagePicker picker = ImagePicker();

    final ImageSource? imageSource = await Get.bottomSheet(
      const SelectImageSourceWidget(),
    );

    XFile? image;
    image = await picker.pickImage(
      source: imageSource!,
    );

    if (image != null) {
      if (['jpg', 'png', 'jpeg'].contains(image.name.split('.').last)) {
        final finalImage = await ImageCropper().cropImage(
          sourcePath: image.path,
        );

        if (finalImage != null) {
          allImages.add(File(finalImage.path));
        }
      }
    }

    update();
  }

  Future removeImage(File image) async {
    await Get.dialog(
      AlertDialogWidget(
        content: 'Você que apagar a imagem ${image.path.split('/').last}?',
        title: 'Tem certeza?',
        confirmOnPressed: () {
          allImages.remove(image);
          update();
          Get.back();
        },
      ),
    );
  }

  Future<List<String>> getImagesInBase64() async {
    final List<String> base64Images = [];
    for (final image in allImages) {
      base64Images.add(
        await image.readAsBytes().then(
          (bytes) {
            return base64Encode(bytes);
          },
        ),
      );
    }
    return base64Images;
  }

  Future setImagesInBase64(List<String> images) async {
    for (final img in images) {
      final tempDir = await getTemporaryDirectory();
      File image = await File(
        '${tempDir.path}/${DateTime.now().toString()}.jpg',
      ).create();

      await image.writeAsBytes(List<int>.from(base64Decode(img)));
      allImages.add(image);
    }
    update();
  }
}
