import 'package:bloc/bloc.dart';
import 'package:devoida_task_manager/app/error/failure.dart';
import 'package:devoida_task_manager/features/home/domain/entities/project_entity.dart';
import 'package:devoida_task_manager/features/home/domain/use_cases/home_use_cases.dart';
import 'package:devoida_task_manager/features/home/presentation/models/project_input_model.dart';
import 'package:devoida_task_manager/shared/shared_entities/base_response_entity.dart';
import 'package:meta/meta.dart';

import '../../../../app/service_locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  //final ProjectsUseCases _projectsUseCases = locator<ProjectsUseCases>();
  final ProjectsUseCases _projectsUseCases = ProjectsUseCases() ;
  final CreateProjectUseCase _createProjectUseCase = locator<CreateProjectUseCase>();

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
}
