import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _checkUserLoginState();

    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequest);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (AuthenticationStatus status) => add(AuthenticationStatusChanged(status)),
    );
  }

  FutureOr<void> _onAuthenticationLogoutRequest(
      AuthenticationLogoutRequest event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  // close subscriptions
  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _checkUserLoginState() async {
    try {
      final result = await _userRepository.makeRequest();
      if (result != null) {
        _authenticationRepository.addStatus(
          AuthenticationStatus.authenticated,
        );
      } else {
        _authenticationRepository.addStatus(
          AuthenticationStatus.unauthenticated,
        );
      }
    } on Exception {
      _authenticationRepository.addStatus(
        AuthenticationStatus.unauthenticated,
      );
    }
  }
}
