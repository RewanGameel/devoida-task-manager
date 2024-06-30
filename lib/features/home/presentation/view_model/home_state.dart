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

//DELETE TASK STATES
class DeleteTaskLoadingState extends HomeState {}

class DeleteTaskSuccessState extends HomeState {
  final BaseResponseEntity baseResponseEntity;

  DeleteTaskSuccessState({required this.baseResponseEntity});
}

class DeleteTaskErrorState extends HomeState {
  final Failure failure;

  DeleteTaskErrorState(this.failure);
}

//MARK TASK AS DONE STATES
class MarkTaskAsDoneLoadingState extends HomeState {}

class MarkTaskAsDoneSuccessState extends HomeState {
  final BaseResponseEntity baseResponseEntity;

  MarkTaskAsDoneSuccessState({required this.baseResponseEntity});
}

class MarkTaskAsDoneErrorState extends HomeState {
  final Failure failure;

  MarkTaskAsDoneErrorState(this.failure);
}

//GET USERS/MEMBERS LIST
class GetUsersLoadingState extends HomeState {}

class GetUsersSuccessState extends HomeState {
  final List<UserEntity> usersEntityList;

  GetUsersSuccessState({required this.usersEntityList});
}

class GetUsersErrorState extends HomeState {
  final Failure failure;

  GetUsersErrorState(this.failure);
}

//LOG USER OUT
class LogoutUserLoadingState extends HomeState {}

class LogoutUserSuccessState extends HomeState {
  LogoutUserSuccessState();
}

class LogoutUserErrorState extends HomeState {
  final Failure failure;

  LogoutUserErrorState(this.failure);
}