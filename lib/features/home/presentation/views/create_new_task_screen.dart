import 'package:devoida_task_manager/app/service_locator.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/common/widget/text_field_with_title_widget.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../models/project_input_model.dart';
import '../models/task_input_model.dart';
import '../view_model/home_cubit.dart';
import '/../../app/extensions.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart' as picker_theme;
import '../../../../shared/common/widget/custom_drop_down_menu.dart';
import '../../../../shared/common/widget/custom_image_widget.dart';
import '../../../../shared/resources/assets_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/manager_values.dart';
import '../../../../shared/resources/size_config.dart';
import '../../../../shared/resources/styles_manager.dart';
import '../widgets/member_tag_widget.dart';

class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({super.key, required this.projectId,});

  final String projectId;

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //TODO THIS IS A STATIC USERS LIST, SHOULD RETRIEVE FROM DB
  List<String> membersList = ["Rewan Gameel", "dZ5xDI2kkyyy6ml0A1Dy", "Test Member"];
  String? _selectedAssignee;
  var selectedDateTime;

  late HomeCubit _viewModel;
  @override
  void dispose() {
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initHomeModule();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _viewModel = HomeCubit();
        return _viewModel;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddTaskLoadingState) {
            _isLoading = true;
          }
          if (state is AddTaskSuccessState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.baseResponseEntity.message)));
            Navigator.pop(context, true);
          }
          if (state is AddTaskErrorState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Add New Task",
            ),
            backgroundColor: ColorManager.backgroundDark,
            body: _isLoading
                ? const Center(
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        )),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: getPadding(horizontal: AppPadding.p24, vertical: AppPadding.p16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldWithTitle(fNameController: _nameController, fieldName: "Task Name", hintText: "Pick a name for your task.."),
                            TextFieldWithTitle(
                              fNameController: _descriptionController,
                              fieldName: "Task Description",
                              hintText: "Add a brief description about your Task..",
                              maxLines: 5,
                            ),
                            ...buildDeadlineSelectionWidget(),
                            ...buildMembersDropDownList(),
                            CustomButton(
                              labelText: "Create Task",
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedDateTime == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select deadline date")));
                                    return;
                                  } else if (_selectedAssignee == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please assign task to a member")));
                                    return;
                                  }
                                  _viewModel.createTask(TaskInputModel(
                                    name: _nameController.text,
                                    description: _descriptionController.text,
                                    assignee: _selectedAssignee!,
                                    projectId: widget.projectId,
                                    deadlineDate: selectedDateTime.toString(),
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  List<Widget> buildDeadlineSelectionWidget() {
    return [
      Text(
        "Deadline Date",
        style: getRegularStyle(),
      ),
      const SizedBox(
        height: AppPadding.p8,
      ),
      GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context, showTitleActions: true, theme: picker_theme.DatePickerTheme(doneStyle: getRegularStyle(color: ColorManager.primary)), onConfirm: (date) {
            setState(() {
              selectedDateTime = date;
            });
          }, currentTime: selectedDateTime != null && selectedDateTime.toString().isNotEmpty ? DateTime.parse(selectedDateTime.toString()) : DateTime.now(), locale: LocaleType.en);
        },
        child: Container(
          padding: getPadding(horizontal: AppPadding.p16, vertical: AppPadding.p12),
          decoration: BoxDecoration(
              color: ColorManager.backgroundDark,
              borderRadius: BorderRadius.circular(AppSize.s4),
              border: Border.all(
                width: 1,
                color: ColorManager.white,
              )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  selectedDateTime != null && selectedDateTime.toString().isNotEmpty ? selectedDateTime.toString().toFormattedDateYear() : "Pick a deadline..",
                  style: selectedDateTime != null && selectedDateTime.toString().isNotEmpty
                      ? getRegularStyle(
                          fontSize: FontSize.s16,
                        )
                      : getHintStyle(),
                ),
              ),
              CustomSvgImage(
                imageName: Assets.assetsSvgCalendar,
                color: ColorManager.primary,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: AppPadding.p16,
      ),
    ];
  }

  List<Widget> buildMembersDropDownList() {
    return [
      Text(
        "Select Assignee",
        style: getRegularStyle(),
      ),
      const SizedBox(
        height: AppPadding.p8,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(
          AppPadding.p4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomDropdown<String>(
                isExpanded: true,
                dropdownButtonStyle: DropdownButtonStyle(
                  elevation: 1,
                  width: AppSize.s24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: ColorManager.backgroundDark,
                ),
                hideIcon: true,
                dropdownStyle: DropdownStyle(
                  elevation: 4,
                  padding: const EdgeInsets.only(right: 16),
                  color: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                items: membersList != null
                    ? membersList!
                        .asMap()
                        .entries
                        .map(
                          (item) => DropdownItem<String>(
                            value: item.value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.value,
                                style: getRegularStyle(),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : [],
                onChange: (int index) {
                  setState(() {
                    _selectedAssignee = membersList![index];
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: getPadding(vertical: AppPadding.p12, horizontal: AppPadding.p16),
                    decoration: BoxDecoration(color: ColorManager.backgroundDark, borderRadius: BorderRadius.circular(AppSize.s4), border: Border.all(color: ColorManager.white)),
                    child: Text(
                      'Select a team member..',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getHintStyle(fontSize: FontSize.s14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: AppPadding.p16,
      ),
      _selectedAssignee == null
          ? const SizedBox.shrink()
          : TagWidget(
              name: _selectedAssignee!,
              onPress: () {
                setState(() {
                  _selectedAssignee = null;
                });
              }),
      const SizedBox(
        height: AppPadding.p16,
      ),
    ];
  }
}
