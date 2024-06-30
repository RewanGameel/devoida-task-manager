import 'package:devoida_task_manager/app/service_locator.dart';
import 'package:devoida_task_manager/features/home/domain/entities/user_entity.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_app_bar.dart';
import 'package:devoida_task_manager/shared/common/widget/text_field_with_title_widget.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/project_input_model.dart';
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

class CreateNewProjectScreen extends StatefulWidget {
  const CreateNewProjectScreen({super.key});

  @override
  State<CreateNewProjectScreen> createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  bool _isLoading = false;
  late HomeCubit _viewModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> membersList = ["Rewan Gameel", "Jane Doe", "Test 1 member"];
  List<UserEntity> usersList = [];
  List<UserEntity> selectedMembersList = [];
  var selectedDateTime;

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
        _viewModel.getUsers();
        return _viewModel;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddProjectLoadingState) {
            _isLoading = true;
          }
          if (state is AddProjectSuccessState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.baseResponseEntity.message)));
            Navigator.pop(context, true);
          }
          if (state is AddProjectErrorState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
          if (state is GetUsersSuccessState) {
            usersList = state.usersEntityList;
          }
          if (state is GetUsersErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Create New Project",
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
                            TextFieldWithTitle(fNameController: _nameController, fieldName: "Project Name", hintText: "Pick a name for your project.."),
                            TextFieldWithTitle(
                              fNameController: _descriptionController,
                              fieldName: "Project Description",
                              hintText: "Add a brief description about your project..",
                              maxLines: 5,
                            ),
                            ...buildDeadlineSelectionWidget(),
                            ...buildMembersDropDownList(),
                            CustomButton(
                              labelText: "Create",
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  _viewModel.createProject(ProjectInputModel(
                                    name: _nameController.text,
                                    id: DateTime.now().toTimestamp().toString(),
                                    description: _descriptionController.text,
                                    members: selectedMembersList.map((e) => e.id).toList(),
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
        "Select Members",
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
              child: CustomDropdown<UserEntity>(
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
                  padding: EdgeInsets.only(right: 16),
                  color: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                items: usersList != null
                    ? usersList!
                        .asMap()
                        .entries
                        .map(
                          (item) => DropdownItem<UserEntity>(
                            value: item.value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.value.name,
                                style: getRegularStyle(),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : [],
                onChange: (int index) {
                  setState(() {
                    if (selectedMembersList.contains(usersList![index])) {
                      return;
                    }
                    selectedMembersList.add(usersList![index]);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: getPadding(vertical: AppPadding.p12, horizontal: AppPadding.p16),
                    decoration: BoxDecoration(color: ColorManager.backgroundDark, borderRadius: BorderRadius.circular(AppSize.s4), border: Border.all(color: ColorManager.white)),
                    child: Text(
                      'Select Members..',
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
      Wrap(
          runSpacing: AppPadding.p8,
          children: selectedMembersList
              .map((member) => TagWidget(
                  name: member.name,
                  onPress: () {
                    setState(() {
                      selectedMembersList.remove(member);
                    });
                  }))
              .toList()),
      const SizedBox(
        height: AppPadding.p16,
      ),
    ];
  }
}
