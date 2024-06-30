import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/domain/use_cases/auth_use_cases.dart';
import '../features/home/domain/use_cases/home_use_cases.dart';
import 'app_prefs.dart';
import 'network/api_app.dart';
import 'network/dio_factory.dart';
import 'network/network_info.dart';

final locator = GetIt.instance;
// serviceLocator
///this general decency injection
Future<void> initAppModule() async {
  //shared preference instance
  final sharedPref = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPref); //this create when call

  //instance app preferences

  locator.registerLazySingleton<AppPreferences>(() => AppPreferences(locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  locator.registerLazySingleton<DioFactory>(() => DioFactory(locator()));

  //app service client
  Dio dio = await locator<DioFactory>().getDio();
  locator.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
}

///this Auth decency injection
initAuthModule() {
  if (!GetIt.I.isRegistered<AuthUseCases>()) {
    locator.registerFactory<AuthUseCases>(() => AuthUseCases());
  }
}

///this Home decency injection
initHomeModule() {
  if (!GetIt.I.isRegistered<ProjectsUseCases>()) {
    locator.registerFactory<ProjectsUseCases>(() => ProjectsUseCases());
  }
   if (!GetIt.I.isRegistered<CreateProjectUseCase>()) {
    locator.registerFactory<CreateProjectUseCase>(() => CreateProjectUseCase());
  }   
   if (!GetIt.I.isRegistered<CreateTaskUseCase>()) {
    locator.registerFactory<CreateTaskUseCase>(() => CreateTaskUseCase());
  }   
   if (!GetIt.I.isRegistered<DeleteProjectUseCase>()) {
    locator.registerFactory<DeleteProjectUseCase>(() => DeleteProjectUseCase());
  }   
   if (!GetIt.I.isRegistered<GetProjectTaskUseCases>()) {
    locator.registerFactory<GetProjectTaskUseCases>(() => GetProjectTaskUseCases());
  }   
   if (!GetIt.I.isRegistered<DeleteTaskUseCase>()) {
    locator.registerFactory<DeleteTaskUseCase>(() => DeleteTaskUseCase());
  }   
   if (!GetIt.I.isRegistered<MarkTaskAsDoneUseCase>()) {
    locator.registerFactory<MarkTaskAsDoneUseCase>(() => MarkTaskAsDoneUseCase());
  }   
   if (!GetIt.I.isRegistered<AuthUseCases>()) {
    locator.registerFactory<AuthUseCases>(() => AuthUseCases());
  }   
   if (!GetIt.I.isRegistered<GetUsersUseCase>()) {
    locator.registerFactory<GetUsersUseCase>(() => GetUsersUseCase());
  }
}
