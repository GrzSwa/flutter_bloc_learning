part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AuthenticationLoading extends AuthenticationEvent {}

class AuthenticationLogIn extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationLogIn({required this.username, required this.password});
}

class AuthenticationLogOut extends AuthenticationEvent {}
