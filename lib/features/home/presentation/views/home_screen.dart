import 'package:devoida_task_manager/app/extensions.dart';
import 'package:devoida_task_manager/features/home/domain/entities/project_entity.dart';
import 'package:devoida_task_manager/features/home/presentation/view_model/home_cubit.dart';
import 'package:devoida_task_manager/shared/common/widget/button_widget.dart';
import 'package:devoida_task_manager/shared/common/widget/custom_empty_widget.dart';
import 'package:devoida_task_manager/shared/resources/color_manager.dart';
import 'package:devoida_task_manager/shared/resources/manager_values.dart';
import 'package:devoida_task_manager/shared/resources/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/service_locator.dart';
import '../../../../app/singlton.dart';
import '../../../../shared/common/widget/custom_image_widget.dart';
import '../../../../shared/resources/assets_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/styles_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late HomeCubit _viewModel;
  bool _isLoading = true;
  List<ProjectEntity> projectsList = [];
  @override
  void initState() {
    initHomeModule();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _viewModel = HomeCubit();
        initHomeModule();
        _viewModel.getProjects();
        return _viewModel;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetProjectsLoadingState) {
            _isLoading = true;
          }
          if (state is GetProjectsSuccessState) {
            _isLoading = false;
            projectsList = state.projectsEntityList;
          }
          if (state is GetProjectsErrorState) {
            _isLoading = false;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorManager.backgroundDark,
              key: _scaffoldKey,
              drawer: buildDrawerView(context),
              floatingActionButton: FloatingActionButton(
                backgroundColor: ColorManager.white,
                elevation: 0,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: ColorManager.primary,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createNewProjectRoute);
                },
              ),
              body: Padding(
                padding: getPadding(horizontal: AppPadding.p24, vertical: AppPadding.p16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: CustomSvgImage(imageName: Assets.assetsSvgDrawerIcon)),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              print('profile screen');
                            },
                            child: SizedBox(
                              height: 32,
                              width: 32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppSize.s50),
                                child: Image.network("https://th.bing.com/th/id/OIP.kmVg8EGl3A3gMfTq7O2XcQAAAA?w=350&h=350&rs=1&pid=ImgDetMain"),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isLoading=true;
                              });
                              _viewModel.getProjects();
                            },
                            child: const SizedBox(
                              height: 32,
                              width: 32,
                              child: Icon(
                                Icons.refresh,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...buildHomeScreenHeader(),
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
                            ...buildProjectsSection(),
                        ],
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

  List<Widget> buildHomeScreenHeader() {
    return [
      const SizedBox(
        height: AppSize.s32,
      ),
      Text(
        "Hello, ${Singleton().user?.email?.split("@").first}!",
        style: getHintStyle(fontSize: FontSize.s14),
      ),
      Text(
        "Elevate Your Productivity Levels & Track Every Task Now! ",
        style: getMediumStyle(fontSize: FontSize.s32),
      ),
      const SizedBox(
        height: AppSize.s16,
      ),
      const Divider(
        color: ColorManager.gray80,
      ),
      const SizedBox(
        height: AppSize.s32,
      ),
    ];
  }

  List<Widget> buildProjectsSection() {
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
            "Your Projects",
            style: getBoldStyle(fontSize: FontSize.s20),
          ),
        ],
      ),
      const SizedBox(
        height: AppSize.s16,
      ),
      projectsList != null && projectsList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projectsList.length,
              itemBuilder: (context, index) {
                //TODO task counts is static , need to be dynamic
                //TODO need to convent into a separate widget and pass parameters
                return Container(
                  width: double.maxFinite,
                  padding: getPadding(
                    vertical: AppPadding.p16,
                    horizontal: AppPadding.p24,
                  ),
                  margin: getPadding(
                    vertical: AppPadding.p8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       projectsList[index].createdAt.toString().toFormattedDateYear(),
                        // projectsList[index].createdAt.toString().toFormattedDateYear(),
                        style: getHintStyle(color: ColorManager.contrastLight),
                      ),  Text(
                       projectsList[index].id,
                        // projectsList[index].createdAt.toString().toFormattedDateYear(),
                        style: getHintStyle(color: ColorManager.contrastLight),
                      ),
                      Text(
                        projectsList[index].name,
                        style: getMediumStyle(fontSize: FontSize.s24),
                      ),
                      Text(
                        projectsList[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(fontSize: FontSize.s14),
                      ),
                      const SizedBox(
                        height: AppPadding.p24,
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s16), border: Border.all(color: ColorManager.white)),
                              padding: getPadding(horizontal: AppPadding.p8, vertical: AppPadding.p4),
                              child: Text(
                                "74 Tasks",
                                style: getRegularStyle(fontSize: FontSize.s14),
                              )),
                          const SizedBox(
                            width: AppPadding.p8,
                          ),
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s16), border: Border.all(color: ColorManager.white)),
                              padding: getPadding(horizontal: AppPadding.p8, vertical: AppPadding.p4),
                              child: Text(
                                "${projectsList[index].members.length} Member",
                                style: getRegularStyle(fontSize: FontSize.s14),
                              )),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.projectDetailsRoute, arguments:{'projectEntity': projectsList[index]});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppSize.s20),
                                  color: ColorManager.black,
                                ),
                                padding: getPadding(horizontal: AppPadding.p8, vertical: AppPadding.p8),
                                child: CustomSvgImage(
                                  imageName: Assets.assetsSvgArrowRight,
                                  color: Colors.white,
                                  width: 20,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              })
          : CustomEmptyScreen(
              title: "No Projects Yet",
              description: "You don't have any projects yet, Get productive create a new one with ease now!",
              emptyScreenTypes: EmptyScreenTypes.emptyList,
              actionWidget: CustomButton(
                onPress: ()async {
                 var result =await  Navigator.pushNamed(context, Routes.createNewProjectRoute);
                if(result==true)
                  {
                    _viewModel.getProjects();
                  }
                 },
                labelText: "+ Create New Project",
              ),
            )
    ];
  }

  Widget buildDrawerView(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: ColorManager.backgroundDark,
        surfaceTintColor: ColorManager.white,
        width: ScreenUtil().screenWidth * 0.9,
        child: ListView(
          padding: getPadding(vertical: AppPadding.p24, horizontal: 24),
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: getPadding(horizontal: AppPadding.p16, vertical: AppPadding.p12),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppPadding.p8),
                        boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 2, color: const Color(0xffd3d1d8).withOpacity(0.22))],
                      ),
                      child: CustomSvgImage(
                        height: 12,
                        width: 12,
                        imageName: Assets.assetsSvgArrowBack,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s50),
                    child: Image.network("https://th.bing.com/th/id/OIP.kmVg8EGl3A3gMfTq7O2XcQAAAA?w=350&h=350&rs=1&pid=ImgDetMain"),
                  ),
                ),
                const SizedBox(
                  width: AppPadding.p16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Singleton().user?.email?.split("@").first}',
                      style: getBoldStyle(fontSize: FontSize.s18),
                    ),
                    Text(
                      '${Singleton().user?.email}',
                      style: getHintStyle(fontSize: FontSize.s14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppPadding.p16),
            Container(
              padding: getPadding(),
              decoration: BoxDecoration(color: ColorManager.backgroundDark, borderRadius: BorderRadius.circular(AppSize.s16)),
              child: Column(
                children: [
                  buildDrawerItem(name: "Home", onTap: () => Navigator.popAndPushNamed(context, Routes.homeRoute)),
                  buildDrawerItem(name: "Personal Info", onTap: () => Navigator.popAndPushNamed(context, Routes.homeRoute)),
                  buildDrawerItem(name: "Projects", onTap: () => Navigator.popAndPushNamed(context, Routes.homeRoute)),
                  buildDrawerItem(name: "Tasks", onTap: () => Navigator.popAndPushNamed(context, Routes.homeRoute)),
                ],
              ),
            ),
            const SizedBox(height: AppPadding.p16),
            Container(
              decoration: BoxDecoration(color: ColorManager.backgroundDark, borderRadius: BorderRadius.circular(AppSize.s16)),
              child: Column(
                children: [
                  buildDrawerItem(name: "FAQs", onTap: () => Navigator.pop(context)),
                ],
              ),
            ),
            const SizedBox(height: AppPadding.p32),
            Container(
              decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(AppSize.s16)),
              child: Column(
                children: [
                  buildDrawerItem(
                      name: "Log Out",
                      isLogout: true,
                      onTap: () {
                        Singleton().clearData(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem({required String name, required Function onTap, bool isLogout = false}) {
    return Padding(
      padding: getPadding(vertical: AppPadding.p4),
      child: ListTile(
        title: Text(
          name,
          style: getRegularStyle(color: isLogout ? ColorManager.backgroundDark : ColorManager.white, fontSize: FontSize.s14),
        ),
        onTap: onTap as VoidCallback,
        trailing: isLogout
            ? null
            : CustomSvgImage(
                color: ColorManager.white,
                imageName: Assets.assetsSvgArrowRight,
              ),
      ),
    );
  }
}
