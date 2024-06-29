import 'package:devoida_task_manager/features/home/domain/entities/project_entity.dart';
import 'package:devoida_task_manager/features/home/presentation/view_model/home_cubit.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/common/state_renderer/state_renderer.dart';
import '../../../../shared/common/widget/custom_empty_widget.dart';
import '../../../../shared/common/widget/custom_image_widget.dart';
import '../../../../shared/common/widget/navigation_component.dart';
import '../../../../shared/resources/assets_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/size_config.dart';
import '../../../../shared/resources/styles_manager.dart';
import '../../domain/entities/task_entity.dart';
import '../widgets/project_actions_bottom_sheet.dart';
import '../widgets/project_completion_bar.dart';
import '../widgets/task_completion_chart.dart';
import '../widgets/task_completion_chart.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.projectEntity});

  final ProjectEntity projectEntity;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  late HomeCubit _viewModel;

  bool _isLoading = true;
  List<TaskEntity>? _projectTasks;
  int _deadlineDaysLeft=0;
  void calculateDeadline() {
    _deadlineDaysLeft = Duration(seconds: DateTime.parse(widget.projectEntity.deadlineDate).difference(DateTime.now()).inSeconds).inDays;
    if (_deadlineDaysLeft < 0) {
      _deadlineDaysLeft = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _viewModel = HomeCubit();
        _viewModel.getProjectTasks(widget.projectEntity.id);
        calculateDeadline();
        return _viewModel;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteProjectLoadingState) {
            showPopupDialog(context: context, stateRendererType: StateRendererType.popupLoadingState);
          }
          if (state is DeleteProjectSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.baseResponseEntity.message)));
            dismissDialog(context);
            Navigator.pop(context,true);
          }
          if (state is DeleteProjectErrorState) {
            dismissDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
          if (state is AddTaskLoadingState) {
            _isLoading = true;
          }
          if (state is AddTaskSuccessState) {
            _isLoading = false;
          }
          if (state is AddTaskErrorState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text(state.failure.message)));
          }
          if (state is GetProjectTasksLoadingState) {
            _isLoading = true;
          }
          if (state is GetProjectTasksSuccessState) {
            _isLoading = false;
            _projectTasks = state.projectTasksEntity;
          }
          if (state is GetProjectTasksErrorState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24, vertical: AppPadding.p16),
              color: ColorManager.backgroundDark,
              child: CustomButton(
                labelText: "Actions",
                onPress: () async {
                  var result = await showModalBottomSheet(
                      backgroundColor: ColorManager.neutralGray900,
                      context: context,
                      builder: (context) {
                        return ProjectActionBottomSheet(
                          projectId: widget.projectEntity.id,
                          viewModel: _viewModel,
                        );
                      });
                  if (result == true) {
                    _viewModel.getProjectTasks(widget.projectEntity.id);
                  }
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
                    const SizedBox(
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
                            "${widget.projectEntity.members.length} Members",
                            style: getRegularStyle(
                              fontSize: FontSize.s14,
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
                              "${_deadlineDaysLeft} Days",
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
                      style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    ...buildTasksSection(),
                    ...buildProjectAnalysisSection(),
                    const SizedBox(height: AppPadding.p80),
                  ],
                ),
              ),
            ),
          );
        },
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
      if (_isLoading)
        const Center(
          child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              )),
        )
      else
        _projectTasks != null && _projectTasks!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _projectTasks!.length,
                itemBuilder: (context, index) {
                  //TODO need to convent into a separate widget and pass parameters
                  return Container(
                    width: double.maxFinite,
                    padding: getPadding(
                      vertical: AppPadding.p12,
                      horizontal: AppPadding.p18,
                    ),
                    margin: getPadding(
                      vertical: AppPadding.p8,
                    ),
                    decoration: BoxDecoration(
                      color: _projectTasks?[index].isDone ?? false ? ColorManager.success : ColorManager.textHeaderColor,
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _projectTasks![index].description,
                                style: getHintStyle(color: _projectTasks?[index].isDone ?? false ? ColorManager.textHeaderColor : ColorManager.white).copyWith(decoration:_projectTasks![index].isDone ? TextDecoration.lineThrough : null),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _projectTasks![index].name,
                                style: getMediumStyle(fontSize: FontSize.s20,color:_projectTasks?[index].isDone ?? false ? ColorManager.textHeaderColor : ColorManager.white).copyWith(decoration:_projectTasks![index].isDone ? TextDecoration.lineThrough : null),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s16,
                        ),
                        InkWell(
                          onTap: () async{
                           var result = await  Navigator.pushNamed(
                              context,
                              Routes.taskDetailsRoute,
                              arguments: {'taskEntity': _projectTasks![index]},
                            );
                           if(result == true){
                             _viewModel.getProjectTasks(widget.projectEntity.id,);
                           }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s20),
                                color: ColorManager.black,
                              ),
                              padding: getPadding(horizontal: AppPadding.p4, vertical: AppPadding.p4),
                              child: CustomSvgImage(
                                imageName: Assets.assetsSvgArrowRight,
                                color: Colors.white,
                                width: 20,
                              )),
                        ),
                      ],
                    ),
                  );
                })
            : CustomEmptyScreen(
                disableIcon: true,
                title: "No Tasks Yet",
                description: "You don't have any projects yet, Get productive create a new one with ease now!",
                actionWidget: Text(
                  "+ Create New Task",
                  style: getRegularStyle(color: ColorManager.primary),
                ),
              ),
      const SizedBox(
        height: AppSize.s16,
      ),
    ];
  }

  List<Widget> buildProjectAnalysisSection() {
    return [
      const Divider(
        color: ColorManager.white,
        thickness: 0.5,
      ),
      const SizedBox(
        height: AppSize.s16,
      ),
      Row(
        children: [
          CustomSvgImage(
            imageName: Assets.assetsSvgAnalytics,
            color: ColorManager.primary,
            width: 24,
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          Text(
            "Analytics",
            style: getBoldStyle(fontSize: FontSize.s20),
          ),
        ],
      ),
      TaskCompletionChart(
        tasks: _projectTasks ?? [],
      ),
      ProjectCompletionBarWidget(
        tasks: _projectTasks ?? [],
      ),
    ];
  }
}
