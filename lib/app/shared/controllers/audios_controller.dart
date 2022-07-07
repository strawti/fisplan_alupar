import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../utils/custom_snackbar.dart';
import '../widgets/alert_dialog_widget.dart';



class AudiosController extends GetxController {
  @override
  void onClose() async {
    record.dispose();
    _timer?.cancel();
    audioPlayers.map((e) => e.player.dispose());
    audioPlayers.map((e) async => await removeAudio(e));

    super.onClose();
  }

  final record = Record();

  Timer? _timer;
  String timerRecord = '00:00:00';

  bool isRecording = false;

  Future startRecording() async {
    isRecording = true;
    update();

    if (await record.hasPermission()) {
      await record.start(path: await getPath());
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timerRecord = "00:00:${timer.tick.toString().padLeft(2, '0')}";

        if (timer.tick == 60) {
          timer.cancel();
          stopRecording();
        }

        update();
      });
    } else {
      CustomSnackbar.to.show("Permissão de gravação negada");
    }

    update();
  }

  Future<String> getPath() async {
    late Directory directory;

    if (GetPlatform.isAndroid) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationSupportDirectory();
    }

    final key = DateTime.now().millisecondsSinceEpoch.toString();

    return '${directory.path}/audio-$key-${audioPlayers.length}.mp4';
  }

  Future stopRecording() async {
    isRecording = false;
    _timer?.cancel();
    timerRecord = '00:00:00';
    update();

    final path = await record.stop();

    final player = AudioPlayer();
    await player.setFilePath(path!);

    audioPlayers.add(AudioTile(path, player));

    update();
  }

  List<AudioTile> audioPlayers = [];
  Future<List<String>> getAudiosInBase64() async {
    List<String> data = [];
    for (var audio in audioPlayers) {
      final file = File(audio.path);
      final bytes = await file.readAsBytes();
      final base64 = base64Encode(bytes);
      data.add(base64);
    }

    return data;
  }

  Future setAudiosInBase64(List<String> audios) async {
    for (var audio in audios) {
      final tempDir = await getTemporaryDirectory();
      File file = await File(
        '${tempDir.path}/${DateTime.now().toString()}.mp4',
      ).create();

      await file.writeAsBytes(List<int>.from(base64Decode(audio)));

      final player = AudioPlayer();
      await player.setFilePath(file.path);

      audioPlayers.add(AudioTile(file.path, player));
    }

    update();
  }

  Future playAudio(AudioTile audio) async {
    audio.isPlaying = true;
    update();
    await audio.player.play();
  }

  Future stopAudio(AudioTile audio) async {
    audio.isPlaying = false;
    update();
    await audio.player.stop();
    await audio.player.seek(Duration.zero);
  }

  Future removeAudio(AudioTile audio) async {
    audio.player.dispose();
    await File(audio.path).delete();
    audioPlayers.remove(audio);
    update();
  }

  Future removeAudioDialog(AudioTile audio) async {
    await Get.dialog(
      AlertDialogWidget(
        content: 'Você que apagar o audio ${audio.path.split('/').last}?',
        title: 'Tem certeza?',
        confirmOnPressed: () {
          removeAudio(audio);
          Get.back();
        },
      ),
    );
  }
}

class AudioTile {
  final String path;
  final AudioPlayer player;

  bool isPlaying = false;

  AudioTile(this.path, this.player);
}
