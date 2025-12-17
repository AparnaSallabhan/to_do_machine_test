part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String passWord;

  AuthSignUp({required this.email, required this.passWord});
}


final class AuthIsUserLoggedIn extends AuthEvent{}