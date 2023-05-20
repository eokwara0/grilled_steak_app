import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/forgot/ui/forgot_page.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu/menu_page.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_page.dart';
import 'package:grilled_steak_app/ui/table/view/table_page.dart';
import 'package:grilled_steak_app/ui/user/ui/user_page.dart';
import 'package:menu_repository/menu_repository.dart';

import '../ui/checkout/ui/checkout.dart';
import '../ui/chef/ui/chef_page.dart';
import '../ui/home/ui/home_page.dart';
import '../ui/login/view/login_page.dart';
import '../ui/menu/ui/menu/menu_edit/menu_edit_page.dart';
import '../ui/menu/ui/menu/menu_manage/menu_manage_page.dart';
import '../ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import '../ui/menu/ui/menu_item/menu_item_add/menu_item_add.dart';
import '../ui/menu/ui/menu_item/menu_item_edit/menu_item_edit_page.dart';
import '../ui/splash/view/splash_page.dart';
import '../ui/widgets/error_page.dart';
import '../ui/widgets/success_page.dart';

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
      GoRoute(
        name: 'manageTable',
        path: '/manageTable',
        builder: (context, state) {
          return const Tablepage();
        },
      ),
      GoRoute(
        name: 'success',
        path: '/success',
        builder: (context, state) {
          return SuccessPage(
            message: state.queryParams['message']!,
          );
        },
      ),
      GoRoute(
        name: 'error',
        path: '/error',
        builder: (context, state) {
          return ErrorPage(
            message: state.queryParams['message']!,
          );
        },
      ),
      GoRoute(
        name: 'checkout',
        path: '/checkout',
        builder: (context, state) {
          return const CheckOutPage();
        },
      ),
      GoRoute(
        name: 'chef',
        path: '/chefPage',
        builder: (context, state) {
          return const ChefPage();
        },
      ),
      GoRoute(
        name: 'users',
        path: '/users',
        builder: (context, state) {
          return const UserPage();
        },
      ),
    ],
  );
}
