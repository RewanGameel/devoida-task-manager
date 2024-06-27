import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida_task_manager/app/constants.dart';
import 'package:devoida_task_manager/features/home/presentation/models/project_input_model.dart';

import '../features/home/domain/entities/project_entity.dart';

class DatabaseServices {
    final FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;

    late final CollectionReference _projectsRef;
    DatabaseServices(){
        _projectsRef = _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).withConverter<ProjectEntity>(fromFirestore: (snapshots,_)=>ProjectEntity.fromJson(snapshots.data()!), toFirestore: (projectEntity,_)=> projectEntity.toJson());
    }
      Future<List<DocumentSnapshot>> getProjects() async {
    final querySnapshot = await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).orderBy('createdAt', descending: true).get();
    print('querySnapshot.docs.first.id: ${querySnapshot.docs.first.id}');
    return querySnapshot.docs;
    
  }
    Future<void> addProjectToFireStoreDB (ProjectInputModel inputModel) async {
        await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).add(inputModel.toJson());
    }
    
    Future<void> deleteProjectFromFireStoreDB (String id) async {
        await _fireStoreDB.collection(Constants.PROJECTS_COLLECTION_KEY).doc(id).delete();
    }
}