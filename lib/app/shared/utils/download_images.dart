import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';

import '../../core/app_token.dart';

Future<List<File>> downloadImages(List<String> images) async {
  List<File> allImages = [];

  final responses = await Future.wait(
    images.map(
      (e) => get(
        Uri.parse(e),
        headers: {
          'Authorization': 'Bearer ${AppToken.instance.token}',
        },
      ),
    ),
  );

  for (var res in responses) {
    try {
      final tempDir = await getTemporaryDirectory();
      File image = await File(
        '${tempDir.path}/${DateTime.now().toString()}.jpg',
      ).create();

      await image.writeAsBytes(res.bodyBytes);
      allImages.add(image);
    } catch (e) {
      log('ERRO IMAGE: $e');
    }
  }

  return allImages;
}
