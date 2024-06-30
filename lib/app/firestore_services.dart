import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida_task_manager/app/constants.dart';
import 'package:devoida_task_manager/features/home/presentation/models/project_input_model.dart';

import '../features/home/domain/entities/project_entity.dart';
import '../features/home/presentation/models/task_input_model.dart';

class DatabaseServices {
    final FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;

    late final CollectionReference _projectsRef;
    DatabaseServices(){
        _projectsRef = _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).withConverter<ProjectEntity>(fromFirestore: (snapshots,_)=>ProjectEntity.fromJson(snapshots.data()!), toFirestore: (projectEntity,_)=> projectEntity.toJson());
    }
      Future<List<DocumentSnapshot>> getProjects() async {
    final querySnapshot = await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).orderBy('createdAt', descending: true).get();
    return querySnapshot.docs;
    
  }
    Future<void> addProjectToFireStoreDB (ProjectInputModel inputModel) async {
        await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).add(inputModel.toJson());
    }
    
    Future<void> deleteProjectFromFireStoreDB (String id) async {
        await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).doc(id).delete();
    }
    
       Future<void> addTaskToFireStoreDB (TaskInputModel inputModel) async {
        await _fireStoreDB.collection(Constants.TASKS_COLLECTION_KEY).add(inputModel.toJson());
    }
    
         Future<List<DocumentSnapshot>> getProjectTasksFromFireStoreDB (String projectId) async {
         final querySnapshot = await _fireStoreDB.collection(Constants.TASKS_COLLECTION_KEY).where('projectId', isEqualTo: projectId).orderBy('createdAt', descending: true).get(); 
       return querySnapshot.docs;
    }         
    
    Future<void> deleteTaskFromFireStoreDB (String taskId) async {
          await _fireStoreDB.collection(Constants.TASKS_COLLECTION_KEY).doc(taskId).delete();
    }
    
        Future<void> markTaskAsCompletedInFireStoreDB (String taskId) async {
          await _fireStoreDB.collection(Constants.TASKS_COLLECTION_KEY).doc(taskId).update({
            'isDone': true
          });
    }
    
          Future<List<DocumentSnapshot>> getUsers() async {
    final querySnapshot = await _fireStoreDB.collection(Constants.USERS_COLLECTION_KEY).orderBy('createdAt', descending: true).get();
    return querySnapshot.docs;
    
  }
    
}