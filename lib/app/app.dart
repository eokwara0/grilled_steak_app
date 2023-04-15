import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:grilled_steak_app/app/routes.dart';
import 'package:grilled_steak_app/ui/forgot/cubit/forgot_password_cubit.dart';
import 'package:service_locator/service_locator.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // repositories
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  // initialization
  @override
  void initState() {
    super.initState();
    registerServices(sl); // registering service
    _userRepository = UserRepository(); // initializing user repository
    _authenticationRepository =
        AuthenticationRepository(); // initializing Authentication repository
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authenticationRepository),
        RepositoryProvider(create: (context) => _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository: _authenticationRepository,
                userRepository: _userRepository),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordCubit(
              authRepo: _authenticationRepository,
            ),
          )
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routers.router,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                Routers.router.push('/');
                break;
              case AuthenticationStatus.unauthenticated:
                Routers.router.push('/login');
                break;
              case AuthenticationStatus.unknown:
                Routers.router.push('/splash');
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
