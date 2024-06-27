part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//GET PROJECTS STATES
class GetProjectsLoadingState extends HomeState {}

class GetProjectsSuccessState extends HomeState {
  final List<ProjectEntity> projectsEntityList;
  GetProjectsSuccessState({required this.projectsEntityList});
}

class GetProjectsErrorState extends HomeState {
  final Failure failure;
  GetProjectsErrorState(this.failure);
}


//ADD NEW PROJECT STATES
class AddProjectLoadingState extends HomeState {}

class AddProjectSuccessState extends HomeState {
  final BaseResponseEntity baseResponseEntity;
  AddProjectSuccessState({required this.baseResponseEntity});
}

class AddProjectErrorState extends HomeState {
  final Failure failure;
  AddProjectErrorState(this.failure);
}