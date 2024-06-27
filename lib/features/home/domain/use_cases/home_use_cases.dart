 
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:devoida_task_manager/app/base_usecase.dart';
import 'package:devoida_task_manager/app/extensions.dart';

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
    final projects = await _databaseServices.addProjectToFireStoreDB(inputModel);
      return Right(BaseResponseEntity(message: "Project Added Successfully", code: 200, status: true,id: 1));
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

class TaskUseCases{}
