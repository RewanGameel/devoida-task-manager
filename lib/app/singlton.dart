import 'dart:async';

import 'package:devoida_task_manager/app/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/resources/routes_manager.dart';
import 'app_prefs.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  static Singleton get instance => _instance;
  
  String? token;
  String? fcmToken;
  User? user;
  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  bool getDeviceTabletMobile() {
    final MediaQueryData data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
    return data.size.shortestSide >= 600;
  }
  void clearData(BuildContext context) {
    //called on logout Success
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    // Navigator.pushNamedAndRemoveUntil(context, Routes.onBoardingRoute, (route) => false);
    Singleton().token = null;
    Singleton().user = null;
    locator<AppPreferences>().clearDataFromSharedPref();
  }
  
}
