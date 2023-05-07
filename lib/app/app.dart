import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:grilled_steak_app/app/routes.dart';
import 'package:grilled_steak_app/ui/forgot/cubit/forgot_password_cubit.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_cubit.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:service_locator/service_locator.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication.dart';
import '../ui/home/ui/search_bottom_sheet/cubit/search_bottom_sheet_cubit.dart';
import '../ui/menu/ui/menu/menu_manage/cubit/menu_manage_cubit.dart';
import '../ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // repositories
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final MenuItemRepository _menuItemRepository;
  late final MenuRepository _menuRepository;

  // initialization
  @override
  void initState() {
    super.initState();

    registerServices(sl); // registering service
    _userRepository = UserRepository(); // initializing user repository
    _authenticationRepository =
        AuthenticationRepository(); // initializing Authentication repository
    _menuItemRepository = MenuItemRepository(); // initializing
    _menuRepository = MenuRepository(); // initializing
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => _authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => _userRepository,
        ),
        RepositoryProvider(
          create: (context) => _menuItemRepository,
        ),
        RepositoryProvider(
          create: (context) => _menuRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ForgotPasswordCubit(
              authRepo: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => SearchBottomSheetCubit(
              menuItemRepo: _menuItemRepository,
            ),
          ),
          BlocProvider(
            create: (context) => MenuItemCubit(),
          ),
          BlocProvider(
            create: (context) => MenuCubit(
              menuRepository: _menuRepository,
              menuItemRepository: _menuItemRepository,
            ),
          ),
          BlocProvider(
            create: (context) => MenuManageCubit(
              menuRepository: _menuRepository,
              menuItemRepository: _menuItemRepository,
            ),
          ),
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
  late Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routers.router,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            /// Checking for the states
            if (state.status == AuthenticationStatus.authenticated) {
              return Routers.router.pushReplacement('/');
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              return Routers.router.pushReplacement('/login');
            }
            return Routers.router.pushReplacement('/splash');
          },
          child: child,
        );
      },
    );
  }
}
