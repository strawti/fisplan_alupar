import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';

import '../../core/app_token.dart';

Future<List<File>> downloadFiles(List<String> paths, String extension) async {
  List<File> files = [];

  final responses = await Future.wait(
    paths.map(
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
        '${tempDir.path}/${DateTime.now().toString()}.$extension',
      ).create();

      await image.writeAsBytes(res.bodyBytes);
      files.add(image);
    } catch (e) {
      log('ERRO IMAGE: $e');
    }
  }

  return files;
}
