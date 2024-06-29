 
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:devoida_task_manager/app/base_usecase.dart';
import 'package:devoida_task_manager/app/extensions.dart';
import 'package:devoida_task_manager/features/home/domain/entities/task_entity.dart';
import 'package:devoida_task_manager/features/home/presentation/models/task_input_model.dart';

import '../../../../app/error/failure.dart';
import '../../../../app/firestore_services.dart';
import '../../../../shared/shared_entities/base_response_entity.dart';
import '../../presentation/models/project_input_model.dart';
import '../entities/project_entity.dart';

class ProjectsUseCases{

  final DatabaseServices _databaseServices = DatabaseServices();
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async{
   try {
    final projects = await _databaseServices.getProjects();
    print('${projects[1]['members'].length}');
      final projectEntities = projects.map((e) => ProjectEntity.fromJson({
      'id': e.id.toString(),
      'name': e['name'].toString(),
      'description': e['description'].toString(),
          'members': e['members'] is List<dynamic>
            ? (e['members'] as List).map((m) => m.toString()).toList()
            : [],
      'createdAt': e['createdAt'].toString().toDateTime().toString(),
      'deadlineDate': e['deadlineDate'].toString().toDateTime().toString(),
      'updatedAt': e['updatedAt'].toString().toDateTime().toString(),
    })).toList();
      return Right(projectEntities);
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
  }
}
class CreateProjectUseCase implements BaseUseCase<ProjectInputModel,BaseResponseEntity>{
    final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Future<Either<Failure, BaseResponseEntity>> execute(ProjectInputModel inputModel)async {
     try {
     await _databaseServices.addProjectToFireStoreDB(inputModel);
      return Right(BaseResponseEntity(message: "Project Added Successfully", code: 200, status: true,id: 1));
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}

class CreateTaskUseCase implements BaseUseCase<TaskInputModel,BaseResponseEntity>{
    final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Future<Either<Failure, BaseResponseEntity>> execute(TaskInputModel inputModel)async {
     try {
     await _databaseServices.addTaskToFireStoreDB(inputModel);
      return Right(BaseResponseEntity(message: "Task Added Successfully", code: 200, status: true,id: 1));
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}


class DeleteProjectUseCase implements BaseUseCase<String,BaseResponseEntity>{
    final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Future<Either<Failure, BaseResponseEntity>> execute(String projectId)async {
     try {
    await _databaseServices.deleteProjectFromFireStoreDB(projectId);
      return Right(BaseResponseEntity(message: "Project Deleted Successfully", code: 200, status: true,id: 1));
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}

class GetProjectTaskUseCases implements BaseUseCase<String,List<TaskEntity>>{

  final DatabaseServices _databaseServices = DatabaseServices();
  @override
  Future<Either<Failure, List<TaskEntity>>> execute(String projectId)async{
    try {
    final tasks = await _databaseServices.getProjectTasksFromFireStoreDB(projectId);
    final List<TaskEntity> projectTasks = tasks.map((e) => TaskEntity.fromJson({
      'id': e.id.toString(),
      'name': e['name'].toString(),
      'description': e['description'].toString(),
      'projectId': e['projectId'].toString(),
      'assignee': e['assignee'].toString(),
      'isDone': e['isDone'] as bool,
      'createdAt': e['createdAt'].toString().toDateTime().toString(),
      'updatedAt': e['updatedAt'].toString().toDateTime().toString(),
      'deadlineDate': e['deadlineDate'].toString().toDateTime().toString(),
    })).toList();
      return Right(projectTasks);
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}

class DeleteTaskUseCase implements BaseUseCase<String,BaseResponseEntity>{
    final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Future<Either<Failure, BaseResponseEntity>> execute(String taskId)async {
     try {
    await _databaseServices.deleteTaskFromFireStoreDB(taskId);
      return Right(BaseResponseEntity(message: "Task Deleted Successfully", code: 200, status: true,id: 1));
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}

class MarkTaskAsDoneUseCase implements BaseUseCase<String,BaseResponseEntity>{
    final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Future<Either<Failure, BaseResponseEntity>> execute(String taskId)async {
     try {
    await _databaseServices.markTaskAsCompletedInFireStoreDB(taskId);
      return Right(BaseResponseEntity(message: "Task Completed Successfully", code: 200, status: true,id: 1));
   } catch (e) {
    return Left(Failure(message: e.toString(), code: 400));
   }
    
  }
}
