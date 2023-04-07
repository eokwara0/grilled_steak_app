import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:grilled_steak_app/bloc_auth/authentication/bloc/authentication_bloc.dart';
import 'package:grilled_steak_app/bloc_auth/authentication/bloc/authentication_state.dart';
import 'package:service_locator/service_locator.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/view/home_page.dart';
import '../login/view/login_page.dart';
import '../splash/view/splash_page.dart';

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
    return RepositoryProvider(
      // repository provider
      create: (context) => _authenticationRepository,

      // bloc providers
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),

        // child view
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
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(), (route) => false);
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}