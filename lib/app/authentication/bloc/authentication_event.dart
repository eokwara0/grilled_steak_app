import 'package:authentication_repository/authentication_repository.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);
  final AuthenticationStatus status;
}

class AuthenticationLogoutRequest extends AuthenticationEvent {}
