import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/audios_controller.dart';

class RecordAudioWidget extends StatelessWidget {
  const RecordAudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: GetBuilder<AudiosController>(
        builder: (control) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                control.isRecording ? 'Gravando...' : 'Gravar',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () async {
                  if (control.isRecording) {
                    await control.stopRecording();
                    Get.back();
                  } else {
                    await control.startRecording();
                  }
                },
                icon: Icon(
                  control.isRecording ? Icons.stop : Icons.mic,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tempo de gravação: ${control.timerRecord}',
              ),
              const Text('O limite é de 60 segundos'),
            ],
          );
        },
      ),
    );
  }
}
