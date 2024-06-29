import 'package:dartz/dartz.dart';
import 'package:devoida_task_manager/app/extensions.dart';
import 'package:devoida_task_manager/app/service_locator.dart';
import 'package:devoida_task_manager/features/home/domain/entities/task_entity.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_image_widget.dart';
import 'package:devoida_task_manager/shared/resources/assets_manager.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/size_config.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/common/state_renderer/state_renderer.dart';
import '../../../../shared/common/widget/button_widget.dart';
import '../../../../shared/common/widget/navigation_component.dart';
import '../../../../shared/resources/font_manager.dart';
import '../view_model/home_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key, required this.taskEntity});

  final TaskEntity taskEntity;
  late HomeCubit _viewModel;
  int? deadlineCountDown;
  bool _reloadWhenGoBack = false;
  void calculateDeadline() {
    deadlineCountDown = Duration(seconds: DateTime.parse(taskEntity.deadlineDate).difference(DateTime.now()).inSeconds).inDays;
    if (deadlineCountDown! < 0) {
      deadlineCountDown = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    calculateDeadline();
    return BlocProvider(
      create: (context) {
        _viewModel = HomeCubit();
        return _viewModel;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteTaskLoadingState) {
            showPopupDialog(context: context, stateRendererType: StateRendererType.popupLoadingState);
          }
          if (state is DeleteTaskSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.baseResponseEntity.message)));
            dismissDialog(context);
            Navigator.pop(context, true);
          }
          if (state is DeleteTaskErrorState) {
            dismissDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
          if (state is MarkTaskAsDoneLoadingState) {
            showPopupDialog(context: context, stateRendererType: StateRendererType.popupLoadingState);
          }
          if (state is MarkTaskAsDoneSuccessState) {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.baseResponseEntity.message)));
            dismissDialog(context);
            taskEntity.isDone = true;
            _reloadWhenGoBack = true;
           // Navigator.pop(context, true);
          }
          if (state is MarkTaskAsDoneErrorState) {
            dismissDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: !taskEntity.isDone
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24, vertical: AppPadding.p16),
                    color: ColorManager.backgroundDark,
                    child: CustomButton(
                      color: ColorManager.success,
                      leftIcon: const Icon(Icons.check_circle_rounded, color: ColorManager.white),
                      labelText: "Mark As Done",
                      onPress: () async {
                        //TODO call markAsDone
                        _viewModel.markTaskAsDone(taskEntity.id);
                      },
                    ),
                  )
                : null,
            appBar: CustomAppBar(
              title: "",
              onBackPress: (){
                Navigator.pop(context, _reloadWhenGoBack);
              },
              actions: [
                InkWell(
                  onTap: () {
                    _viewModel.deleteTask(taskEntity.id);
                  },
                  child: Row(
                    children: [
                      CustomSvgImage(
                        imageName: Assets.assetsSvgTrash,
                        color: ColorManager.white,
                        width: AppSize.s20,
                      ),
                      Text(
                        "Delete Task",
                        style: getHintStyle(color: ColorManager.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppPadding.p8,
                ),
              ],
            ),
            backgroundColor: ColorManager.backgroundDark,
            body: SingleChildScrollView(
              child: Padding(
                padding: getPadding(all: AppPadding.p24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Name",
                      style: getHintStyle(),
                    ),
                    Text(
                      taskEntity.name,
                      style: getHintStyle(color: ColorManager.primary, fontSize: FontSize.s32),
                    ),
                    const SizedBox(
                      height: AppPadding.p16,
                    ),
                    const Divider(
                      color: ColorManager.white,
                      thickness: 0.5,
                    ),
                    const SizedBox(
                      height: AppPadding.p16,
                    ),
                    Text(
                      "Additional Information",
                      style: getHintStyle(),
                    ),
                    Text(
                      taskEntity.description,
                      style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    Text(
                      "Deadline Date",
                      style: getHintStyle(),
                    ),
                    Text(
                      taskEntity.deadlineDate.toFormattedDateYear(),
                      style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Days remaining",
                                style: getHintStyle(),
                              ),
                              Text(
                                " $deadlineCountDown Day/s",
                                style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24, vertical: AppPadding.p8),
                          decoration: BoxDecoration(
                            color: taskEntity.isDone ? ColorManager.success : ColorManager.missing,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            taskEntity.isDone ? "Completed" : "Pending",
                            style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppPadding.p16),
                    const SizedBox(height: AppPadding.p8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
