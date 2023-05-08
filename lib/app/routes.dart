import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/forgot/ui/forgot_page.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu/menu_page.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_page.dart';
import 'package:menu_repository/menu_repository.dart';

import '../ui/home/ui/home_page.dart';
import '../ui/login/view/login_page.dart';
import '../ui/menu/ui/menu/menu_edit/menu_edit_page.dart';
import '../ui/menu/ui/menu/menu_manage/menu_manage_page.dart';
import '../ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import '../ui/menu/ui/menu_item/menu_item_add/menu_item_add.dart';
import '../ui/menu/ui/menu_item/menu_item_edit/menu_item_edit_page.dart';
import '../ui/splash/view/splash_page.dart';

// Routers class
class Routers {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => const Forgot(),
      ),
      GoRoute(
        name: 'menuItem',
        path: '/menuItem',
        builder: (context, state) {
          MenuItem? item = context.watch<MenuItemCubit>().state.item;
          return MenuItemPage(
            item: item,
          );
        },
      ),
      GoRoute(
        path: '/menuItem/edit',
        name: 'menu_item_edit',
        builder: (context, state) {
          return const MenuItemEditPage();
        },
      ),
      GoRoute(
        path: '/menuItem/add',
        name: 'menu_item_add',
        builder: (context, state) {
          return const MenuItemAddPage();
        },
      ),
      GoRoute(
        path: '/menu',
        name: 'name',
        builder: (context, state) {
          return const MenuPage();
        },
      ),
      GoRoute(
        name: 'manageMenu',
        path: '/manageMenu',
        builder: (context, state) {
          return const MenuManagePage();
        },
      ),
      GoRoute(
        name: 'menuEdit',
        path: '/menuEdit',
        builder: (context, state) {
          return const MenuEditPage();
        },
      ),
    ],
  );
}
