import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../domain/entities/task_entity.dart';

class ProjectCompletionBarWidget extends StatelessWidget {
  const ProjectCompletionBarWidget({super.key, required this.tasks});

  final List<TaskEntity> tasks;
  @override
  Widget build(BuildContext context) {
    //must make sure tasks are > 0
    final ratio = tasks.where((task) => task.isDone).length / (tasks.length > 0 ? tasks.length : 1);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Progress",style: getMediumStyle(color: ColorManager.textColor,fontSize: FontSize.s16),),
            Text((ratio*100).toStringAsFixed(0)+"%",style: getMediumStyle(color: ColorManager.textColor,fontSize: FontSize.s16),),
          ],
        ),
          const SizedBox(height: 8),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(AppSize.s8),
          value: ratio,
          backgroundColor: ColorManager.white,
          color:ColorManager.success,
        ),
      ],
    );
  }
}
