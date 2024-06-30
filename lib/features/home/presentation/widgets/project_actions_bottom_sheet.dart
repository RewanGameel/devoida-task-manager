import 'package:dartz/dartz.dart';
import 'package:devoida_task_manager/features/home/presentation/view_model/home_cubit.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_image_widget.dart';
import 'package:devoida_task_manager/shared/resources/assets_manager.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/routes_manager.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/project_entity.dart';

class ProjectActionBottomSheet extends StatelessWidget {
  const ProjectActionBottomSheet({super.key,required this.projectId,required this.viewModel,required this.projectEntity});
  final String projectId;
  final ProjectEntity projectEntity;
  final HomeCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
            color: ColorManager.textHeaderColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: ColorManager.textHeaderColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Manage Project",
                style: getMediumStyle(color: ColorManager.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 25,
                  height: 25,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: ColorManager.backgroundDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.42),
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: ColorManager.white,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomButton(
            onPress: () async{
           var result = await  Navigator.pushNamed(context, Routes.createNewTaskRoute, arguments: {'projectId': projectId,'projectEntity':projectEntity});
           if(result==true){
            Navigator.pop(context, true);
           }
            },
            leftIcon: CustomSvgImage(
              imageName: Assets.assetsSvgNewTask,
              width: 16,
              color: ColorManager.white,
            ),
            labelText: 'Add New Task',
          ),
        ),
        const SizedBox(
          height:AppPadding.p12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomButton(
            onPress: () {
              viewModel.deleteProject(projectId);
              Navigator.pop(context);
            },
            labelText: 'Delete Project',
            textColor: ColorManager.white,
            leftIcon: CustomSvgImage(
              imageName: Assets.assetsSvgTrash,
              width: 16,
              color: ColorManager.white,
            ),
            borderColor: ColorManager.white,
            isFilledColor: false,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ]),
    );
  }
}
