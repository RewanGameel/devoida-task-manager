import 'package:devoida_task_manager/features/home/domain/entities/project_entity.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/common/widget/custom_empty_widget.dart';
import '../../../../shared/common/widget/custom_image_widget.dart';
import '../../../../shared/resources/assets_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/size_config.dart';
import '../../../../shared/resources/styles_manager.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.projectEntity});

  final ProjectEntity projectEntity;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: CustomButton(
          labelText: "Actions",
          onPress: () {
            //show actions bottom sheet
          },
        ),
      ),
      backgroundColor: ColorManager.backgroundDark,
      appBar: CustomAppBar(
        title: "",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.projectEntity.name,
                style: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s32),
              ),
              SizedBox(
                height: AppPadding.p8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p8),
                    decoration: BoxDecoration(
                      // color: ColorManager.background,
                      border: Border.all(color: ColorManager.primary),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      widget.projectEntity.members.length.toString() + " Members",
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        // color: ColorManager.te,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deadline in ",
                        style: getHintStyle(),
                      ),
                      Text(
                        "59 Days",
                        style: getRegularStyle(),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                color: ColorManager.white,
                thickness: 0.5,
              ),
              const SizedBox(height: 16),
              Text(
                "Additional Information",
                style: getHintStyle(),
              ),
              Text(
                widget.projectEntity.description,
                style: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16),
              ),
              const SizedBox(height: 16),
              ...buildTasksSection(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTasksSection() {
    return [
      Row(
        children: [
          CustomSvgImage(
            imageName: Assets.assetsSvgInfo,
            color: ColorManager.primary,
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          Text(
            "Project Tasks",
            style: getBoldStyle(fontSize: FontSize.s20),
          ),
        ],
      ),
      const SizedBox(
        height: AppSize.s16,
      ),
      // ListView.builder(
      //     shrinkWrap: true,
      //     physics: const NeverScrollableScrollPhysics(),
      //     itemCount: 3,
      //     itemBuilder: (context, index) {
      //       //TODO need to convent into a separate widget and pass parameters
      //       return Container(
      //         width: double.maxFinite,
      //         padding: getPadding(
      //           vertical: AppPadding.p12,
      //           horizontal: AppPadding.p18,
      //         ),
      //         margin: getPadding(
      //           vertical: AppPadding.p8,
      //         ),
      //         decoration: BoxDecoration(
      //           color: ColorManager.contrastLight,
      //           borderRadius: BorderRadius.circular(AppSize.s8),
      //         ),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Lorem Ibsim dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      //                     style: getHintStyle(color: ColorManager.textHeaderColor),
      //                     maxLines: 1,
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                   Text(
      //                     "Task Name",
      //                     style: getMediumStyle(fontSize: FontSize.s20, color: ColorManager.textHeaderColor),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             const SizedBox(
      //               width: AppSize.s16,
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 Navigator.pushNamed(
      //                   context,
      //                   Routes.homeRoute,
      //                 );
      //               },
      //               child: Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(AppSize.s20),
      //                     color: ColorManager.black,
      //                   ),
      //                   padding: getPadding(horizontal: AppPadding.p4, vertical: AppPadding.p4),
      //                   child: CustomSvgImage(
      //                     imageName: Assets.assetsSvgArrowRight,
      //                     color: Colors.white,
      //                     width: 20,
      //                   )),
      //             ),
      //           ],
      //         ),
      //       );
      //     }),
      CustomEmptyScreen(
        disableIcon: true,
        title: "No Tasks Yet",
        description: "You don't have any projects yet, Get productive create a new one with ease now!",
        
        actionWidget:Text("+ Create New Task",style: getRegularStyle(color: ColorManager.primary),),
      ),
        const SizedBox(
                    height: AppSize.s80,
                  ),
    ];
  }
}
