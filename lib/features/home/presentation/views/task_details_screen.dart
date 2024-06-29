import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/size_config.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:flutter/material.dart';
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      backgroundColor: ColorManager.backgroundDark,
      body: SingleChildScrollView(
        child: Padding(
          padding: getPadding(all: AppPadding.p24),
          child:Column(
            children: [
              Text("Task Name",style: getHintStyle(),),
            ],
          ) ,
        ),
      ),
    );
  }
}
