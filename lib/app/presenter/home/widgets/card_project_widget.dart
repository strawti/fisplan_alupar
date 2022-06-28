import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../infra/models/responses/project_model.dart';
import '../../../routes/arguments/inspections_page_arguments.dart';
import '../../inspections/inspections_page.dart';

class CardProjectWidget extends StatelessWidget {
  const CardProjectWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          InspectionsPage.route,
          arguments: InspectionsPageArguments(
            project,
          ),
        );
      },
      child: SizedBox(
        width: context.width * .95,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  '${project.progress}% concluído',
                  style: const TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (project.description!.isNotEmpty) const SizedBox(height: 12),
                Text(
                  project.description ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
