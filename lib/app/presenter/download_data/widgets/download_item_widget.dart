import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadItemWidget<T extends GetxController> extends StatelessWidget {
  final dynamic control;
  final String title;
  const DownloadItemWidget({
    Key? key,
    required this.control,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return ListTile(
          isThreeLine: true,
          leading: control.isLoading ? const CircularProgressIndicator() : null,
          title: Text(title),
          subtitle: Text(
            "Última atualização: ${control.lastUpdate}",
          ),
          trailing: control.isLoading
              ? null
              : IconButton(
                  onPressed: () async {
                    await control.fetch(online: true);
                  },
                  icon: const Icon(Icons.sync),
                ),
        );
      },
    );
  }
}
