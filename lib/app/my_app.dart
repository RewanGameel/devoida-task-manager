import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../shared/resources/routes_manager.dart';
import '../shared/resources/theme_manager.dart';
import 'constants.dart';
import 'network/token.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  factory MyApp() => MyApp._internal(); //this to help to create singleton instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
            theme: getAppTheme(),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
          );
        });
  }
}
