import 'package:bloc/bloc.dart';
import 'package:devoida_task_manager/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../app/error/failure.dart';
import '../../../../app/service_locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthUseCases _authUseCases = locator<AuthUseCases>();

  void createUserWithEmailAndPassword({required String email, required String password, required String userName}) async {
    emit(CreateUserLoadingState());
    (await _authUseCases.createUserWithEmailAndPassword(
      email: email,
      password: password,
      userName: userName,
    ))
        .fold((failure) {
      emit(CreateUserErrorState(failure: failure));
    }, (userEntity) {
      return {emit(CreateUserSuccessState(userEntity: userEntity))};
    });
  }
  
  void loginUserWithEmailAndPassword({required String email, required String password}) async {
    emit(LoginUserLoadingState());
    (await _authUseCases.loginWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .fold((failure) {
      emit(LoginUserErrorState(failure: failure));
    }, (userEntity) {
      return {emit(LoginUserSuccessState(userEntity: userEntity))};
    });
  }


}
