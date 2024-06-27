import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/my_app.dart';

import 'app/network/bloc_observe.dart';
import 'app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
 
  await initAppModule();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
void initializeFirebase() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDlm-NThe6Mrgxc-lsiFPKvK60uol_Kz90",
    appId: "1:359413648306:android:540ed511967839ed40b2ab",
    messagingSenderId: "359413648306",
    projectId: "task-manager-acd0a",
  )
      //options: DefaultFirebaseOptions.currentPlatform,
      );
   //allows to collect the data from the cache instead of re-loading it -> persistenceEnabled: true
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
}