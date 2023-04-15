import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // Initialize the repositories
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  // Constructor
  AuthenticationBloc({
    //
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,

    //
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    // Event handlers
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequest>(_onAuthenticationLogoutRequest);

    // Stream subscription handler
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (AuthenticationStatus status) => add(AuthenticationStatusChanged(status)),
    );
  }

  // logout event handler
  FutureOr<void> _onAuthenticationLogoutRequest(
      AuthenticationLogoutRequest event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  // OnStatus change
  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    // check for the current state
    switch (event.status) {
      // if unauthenticated emit unauthenticatedstate
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());

      // if authenticated find user and emit authenticated state
      // with user .
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );

      // if state is unkonwn emit unknown state.
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  // try retrieving user
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
}
