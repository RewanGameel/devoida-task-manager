import 'dart:async';
import 'package:devoida_task_manager/app/singlton.dart';
import 'package:devoida_task_manager/shared/resources/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/app_prefs.dart';
import '../../app/service_locator.dart';
import '../../shared/common/widget/custom_image_widget.dart';
import '../../shared/resources/assets_manager.dart';
import '../../shared/resources/font_manager.dart';
import '../../shared/resources/manager_values.dart';
import 'package:flutter/material.dart';
import '../../shared/resources/color_manager.dart';
import '../../shared/resources/constants_manager.dart';
import '../../shared/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    String? userJson = await locator<AppPreferences>().getDataToSharedPref(key: 'user');

    if(userJson != null) {
      //Singleton().user = User();
      // Navigator.pushReplacementNamed(
      //   context,
      //   Routes.homeRoute,
      // );
    }
    Navigator.pushReplacementNamed(
      context,
      Routes.onBoardingRoute,
    );
  }

  @override
  void initState() {
    initAuthModule();
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundDark,
      body: Center(
        child: Text(
         "DEVOIDA",
          style: getBlackStyle(fontSize: FontSize.s12,color: ColorManager.primary),
        ),
      ),
    );
  }
}
