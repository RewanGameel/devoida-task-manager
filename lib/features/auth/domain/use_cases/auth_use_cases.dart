 
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:devoida_task_manager/app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/error/failure.dart';

class AuthUseCases {
  final _auth = FirebaseAuth.instance;
    final FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;

  Future<Either<Failure, User>> createUserWithEmailAndPassword({required String email, required String password, required String userName}) async {
    try {
      final UserCredential createdUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       // Store user details in Firestore
    await _fireStoreDB.collection(Constants.USERS_COLLECTION_KEY).doc(createdUser.user?.uid).set({
      'uid': createdUser.user?.uid,
      'email': email,
      'name': userName,
      'createdAt': FieldValue.serverTimestamp(),
    });
      return Right(createdUser.user!);
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email.';
            break;
          default:
            errorMessage = '${e.message}';
        }
      } else {
        errorMessage = 'An unknown error occurred: $e';
      }
      return Left(Failure(code: 400, message: "$errorMessage"));
    }
  }

  Future<Either<Failure, User>> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential createdUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Right(createdUser.user!);
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email.';
            break;
          default:
            errorMessage = '${e.message}';
        }
      } else {
        errorMessage = 'An unknown error occurred: $e';
      }
      return Left(Failure(code: 400, message: "$errorMessage"));
    }
  }

  Future<Either<Failure, void>> logoutUser() async {
    try {
      await _auth.signOut();
      return const Right(Void);
    } catch (e) {
      print('Error in Logout user : $e');
      return Left(Failure(code: 400, message: "Could not Logout:  $e"));
    }
  }


}

