import 'package:devoida_task_manager/shared/common/widget/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/common/widget/button_widget.dart';
import '../../../../shared/common/widget/custom_app_bar.dart';
import '../../../../shared/resources/assets_manager.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/styles_manager.dart';

import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/manager_values.dart';
import '../../../../shared/resources/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundDark,
      appBar: CustomAppBar(
        title: "",
        height: 0,
        canGoBack: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgImage(
            imageName:Assets.assetsImageOnboarding,
            width: ScreenUtil.defaultSize.width,
          ),
          Container(
            margin: getPadding(horizontal: AppPadding.p24, vertical: AppPadding.p16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  "Your Daily Task Manager",
                  textAlign: TextAlign.center,
                  style: getBoldStyle(fontSize: FontSize.s28),
                ),
                const SizedBox(
                  height: AppPadding.p12,
                ),
                Text(
                  "Lorem ipsum dolor sit amet consectetur elit, consectetur adipisicing elit sint consectetur adipisicing elit sint lorem.",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.neutralGray700),
                ),
              ],
            ),
          ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40, vertical: AppPadding.p32),
            child: CustomButton(onPress: () => Navigator.popAndPushNamed(context, Routes.loginRoute), labelText: "Get Started"),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
          //   child: CustomButton(
          //     onPress: () => Navigator.popAndPushNamed(context, Routes.loginRoute),
          //     labelText: "Login",
          //     textColor:  ColorManager.black,
          //     color: ColorManager.lightPrimary,
          //   ),
          // ),
        ],
      ),
    );
  }
}
