import 'package:devoida_task_manager/features/auth/presentation/views/login_screen.dart';
import 'package:devoida_task_manager/features/auth/presentation/views/onboarding_screen.dart';
import 'package:devoida_task_manager/features/auth/presentation/views/signup_screen.dart';
import 'package:devoida_task_manager/features/home/presentation/views/home_screen.dart';

import '../../features/home/domain/entities/project_entity.dart';
import '../../features/home/presentation/views/create_new_project_screen.dart';
import '../../features/home/presentation/views/project_details_screen.dart';
import '../../features/splash/splash_view.dart';
import 'strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/homeRoute';
  static const String loginRoute = '/loginRoute';
  static const String signUpRoute = '/signUpRoute';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String createNewProjectRoute = '/createNewProjectRoute';
  static const String projectDetailsRoute = '/projectDetailsRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
        
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());      
        
      case Routes.createNewProjectRoute:
        return MaterialPageRoute(builder: (_) => CreateNewProjectScreen());
        
      case Routes.projectDetailsRoute:
          var arguments = settings.arguments != null ? settings.arguments as Map : null;
        ProjectEntity? projectEntity;
        if (arguments != null) {
          projectEntity = arguments['projectEntity'];
        }
        return MaterialPageRoute(builder: (_) => ProjectDetailsScreen(projectEntity:projectEntity!));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}