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


//ADD NEW TASK STATES
class AddTaskLoadingState extends HomeState {}

class AddTaskSuccessState extends HomeState {
  final BaseResponseEntity baseResponseEntity;
  AddTaskSuccessState({required this.baseResponseEntity});
}

class AddTaskErrorState extends HomeState {
  final Failure failure;
  AddTaskErrorState(this.failure);
}


//DELETE PROJECT STATES
class DeleteProjectLoadingState extends HomeState {}

class DeleteProjectSuccessState extends HomeState {
  final BaseResponseEntity baseResponseEntity;
  DeleteProjectSuccessState({required this.baseResponseEntity});
}

class DeleteProjectErrorState extends HomeState {
  final Failure failure;
  DeleteProjectErrorState(this.failure);
}

//GET PROJECT TASKS STATES
class GetProjectTasksLoadingState extends HomeState {}

class GetProjectTasksSuccessState extends HomeState {
  final List<TaskEntity> projectTasksEntity;
  GetProjectTasksSuccessState({required this.projectTasksEntity});
}

class GetProjectTasksErrorState extends HomeState {
  final Failure failure;
  GetProjectTasksErrorState(this.failure);
}