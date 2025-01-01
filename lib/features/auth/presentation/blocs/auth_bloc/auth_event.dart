part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String role;

  AuthSignUp({required this.email, required this.password, required this.name, required this.role});
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthCurrentUser extends AuthEvent {
  AuthCurrentUser();
}
final class AuthLogoutUser extends AuthEvent {}
