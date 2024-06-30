import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:devoida_task_manager/app/error/failure.dart';
import 'package:devoida_task_manager/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:devoida_task_manager/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:devoida_task_manager/features/home/domain/entities/project_entity.dart';
import 'package:devoida_task_manager/features/home/domain/entities/task_entity.dart';
import 'package:devoida_task_manager/features/home/domain/entities/user_entity.dart';
import 'package:devoida_task_manager/features/home/domain/use_cases/home_use_cases.dart';
import 'package:devoida_task_manager/features/home/presentation/models/project_input_model.dart';
import 'package:devoida_task_manager/features/home/presentation/models/task_input_model.dart';
import 'package:devoida_task_manager/shared/shared_entities/base_response_entity.dart';
import 'package:meta/meta.dart';

import '../../../../app/service_locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  //final ProjectsUseCases _projectsUseCases = locator<ProjectsUseCases>();
  final ProjectsUseCases _projectsUseCases = ProjectsUseCases() ;
  final CreateProjectUseCase _createProjectUseCase = locator<CreateProjectUseCase>();
  final DeleteProjectUseCase _deleteProjectUseCase = locator<DeleteProjectUseCase>();
  final CreateTaskUseCase _createTaskUseCase = locator<CreateTaskUseCase>();
  final GetProjectTaskUseCases _getProjectTaskUseCases = locator<GetProjectTaskUseCases>();
  final DeleteTaskUseCase _deleteTaskUseCase = locator<DeleteTaskUseCase>();
  final MarkTaskAsDoneUseCase _markTaskAsDoneUseCase = locator<MarkTaskAsDoneUseCase>();
  final GetUsersUseCase _getUsersUseCase = locator<GetUsersUseCase>();
  final AuthUseCases _logoutUserUseCase = locator<AuthUseCases>();

  Future<void> getProjects() async {
        emit(GetProjectsLoadingState());
    (await _projectsUseCases.getProjects())
        .fold((failure) {
      print('error: ${failure.message}');
      emit(GetProjectsErrorState(failure));
    }, (projects) {
      return {emit(GetProjectsSuccessState(projectsEntityList: projects))};
    });
  }  
  
  Future<void> createProject(ProjectInputModel inputModel) async {
        emit(AddProjectLoadingState());
    (await _createProjectUseCase.execute(inputModel))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(AddProjectErrorState(failure));
    }, (response) {
      return {emit(AddProjectSuccessState(baseResponseEntity: response))};
    });
  }
  
  Future<void> createTask(TaskInputModel inputModel) async {
        emit(AddTaskLoadingState());
    (await _createTaskUseCase.execute(inputModel))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(AddTaskErrorState(failure));
    }, (response) {
      return {emit(AddTaskSuccessState(baseResponseEntity: response))};
    });
  }

  Future<void> getProjectTasks(String projectId) async {
        emit(GetProjectTasksLoadingState());
    (await _getProjectTaskUseCases.execute(projectId))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(GetProjectTasksErrorState(failure));
    }, (tasks) {
      return {emit(GetProjectTasksSuccessState(projectTasksEntity: tasks))};
    });
  }
  
  Future<void> deleteProject(String projectId) async {
        emit(DeleteProjectLoadingState());
    (await _deleteProjectUseCase.execute(projectId))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(DeleteProjectErrorState(failure));
    }, (response) {
      return {emit(DeleteProjectSuccessState(baseResponseEntity: response))};
    });
  }
  
  Future<void> deleteTask(String taskId) async {
        emit(DeleteTaskLoadingState());
    (await _deleteTaskUseCase.execute(taskId))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(DeleteTaskErrorState(failure));
    }, (response) {
      return {emit(DeleteTaskSuccessState(baseResponseEntity: response))};
    });
  }
  
  Future<void> markTaskAsDone(String taskId) async {
        emit(MarkTaskAsDoneLoadingState());
    (await _markTaskAsDoneUseCase.execute(taskId))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(MarkTaskAsDoneErrorState(failure));
    }, (response) {
      return {emit(MarkTaskAsDoneSuccessState(baseResponseEntity: response))};
    });
  }

  
    Future<void> getUsers() async {
        emit(GetUsersLoadingState());
    (await _getUsersUseCase.execute(Void))
        .fold((failure) {
      print('error: ${failure.message}');
      emit(GetUsersErrorState(failure));
    }, (users) {
      return {emit(GetUsersSuccessState(usersEntityList: users))};
    });
  }
  
 Future<void> logoutUser() async {
    emit(LogoutUserLoadingState());
    (await _logoutUserUseCase.logoutUser())
        .fold((failure) {
      emit(LogoutUserErrorState(failure));
    }, (response) {
      return {emit(LogoutUserSuccessState())};
    });
  }

}
