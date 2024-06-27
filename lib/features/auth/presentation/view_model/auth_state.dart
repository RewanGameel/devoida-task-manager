part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//SIGN UP STATES
class CreateUserSuccessState extends AuthState {
  final User userEntity;

  CreateUserSuccessState({required this.userEntity});
}

class CreateUserErrorState extends AuthState {
  final Failure failure;

  CreateUserErrorState({required this.failure});
}

class CreateUserLoadingState extends AuthState {}


//LOGIN STATES
class LoginUserSuccessState extends AuthState {
  final User userEntity;
  LoginUserSuccessState({required this.userEntity});
}

class LoginUserErrorState extends AuthState {
  final Failure failure;
  LoginUserErrorState({required this.failure});
}

class LoginUserLoadingState extends AuthState {}