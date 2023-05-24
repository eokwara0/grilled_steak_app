import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:grilled_steak_app/app/routes.dart';
import 'package:grilled_steak_app/ui/forgot/cubit/forgot_password_cubit.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu/menu_edit/cubit/menu_edit_cubit.dart';
import 'package:grilled_steak_app/ui/table/cubit/manage_table_cubit.dart';
import 'package:grilled_steak_app/ui/table/view/table_reservation_bottom_sheet.dart/cubit/reservation_bottom_sheet_cubit.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:service_locator/service_locator.dart';
import 'package:table_reservation_repository/table_reservation_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication.dart';
import '../ui/cart/cubit/cart_cubit.dart';
import '../ui/home/ui/search_bottom_sheet/cubit/search_bottom_sheet_cubit.dart';
import '../ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import '../ui/table/view/table_edit_bottom_sheet.dart/cubit/table_edit_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late final ReservationRepository _reservationRepository;
  late final OrderRepository _orderRepository;

  @override
  void initState() {
    registerServices(sl);
    _userRepository = UserRepository();
    _authenticationRepository = AuthenticationRepository();
    _menuItemRepository = MenuItemRepository();
    _menuRepository = MenuRepository();
    _reservationRepository = ReservationRepository();
    _orderRepository = OrderRepository();
    super.initState();
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
        ),
        RepositoryProvider(
          create: (context) => _reservationRepository,
        ),
        RepositoryProvider(
          create: (context) => _orderRepository,
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
            create: (context) => MenuEditCubit(
              repo: _menuRepository,
            ),
          ),
          BlocProvider(
            create: (context) => TableEditCubit(
              reservationRepository: _reservationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ManageTableCubit(
              reservationRepository: _reservationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ReservationBottomSheetCubit(
              repo: _reservationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(
              orderRepo: _orderRepository,
              menuRepo: _menuItemRepository,
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: Routers.router,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return state.user.isChef
                  ? Routers.router.pushReplacement('/chefPage')
                  : Routers.router.pushReplacement('/');
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
