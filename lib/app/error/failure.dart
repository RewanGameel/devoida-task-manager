import 'package:equatable/equatable.dart';

/// Failure is a class that has a code and a message.
class Failure extends Equatable{
  int code;
  String message;
  Failure({
    required this.code,
    required this.message,
  });
  
  @override
  
  List<Object?> get props => [];
}
