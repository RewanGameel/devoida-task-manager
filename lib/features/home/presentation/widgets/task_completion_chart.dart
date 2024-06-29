import 'package:devoida_task_manager/shared/common/widget/custom_empty_widget.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/size_config.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:devoida_task_manager/features/home/domain/entities/task_entity.dart';
class TaskCompletionChart extends StatelessWidget {
  final List<TaskEntity> tasks;

  TaskCompletionChart({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isDone).length;
    final pendingTasks = tasks.length - completedTasks;
 // final completedTasks = 7;
 //    final pendingTasks =3;

   if(tasks.isEmpty) {
     return  Center(child: Padding(
       padding: getPadding(vertical: AppPadding.p24),
       child:const CustomEmptyScreen(title: "No Tasks Found",description: "Please add some tasks to see the project analysis",disableIcon: true,),
     ));
   } else {
     return SfCircularChart(
      title: ChartTitle(text: 'Project Completion Status',textStyle: getHintStyle(),alignment: ChartAlignment.near),
      legend: Legend(isVisible: true,textStyle: getHintStyle(),alignment: ChartAlignment.near ),
      series: <CircularSeries>[
        DoughnutSeries<TaskData, String>(
          dataSource: [
            TaskData(status: 'Completed',count:  completedTasks),
            TaskData(status:'Pending', count:pendingTasks),
          ],
          xValueMapper: (TaskData data, _) => data.status,
          yValueMapper: (TaskData data, _) => data.count,
           
           pointColorMapper: (TaskData data, _) => data.status == 'Completed'
              ? ColorManager.success
              : ColorManager.missing,
          dataLabelSettings: DataLabelSettings(isVisible: false),
        ),
      ],
    );
   }
  }
}

class TaskData {
  final String status;
  final int count;

  TaskData({required this.status,required this.count});
}
