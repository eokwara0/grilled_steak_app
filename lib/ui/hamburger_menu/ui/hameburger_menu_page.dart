import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/app/authentication/authentication.dart';
import 'package:grilled_steak_app/ui/table/cubit/manage_table_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cart/cubit/cart_cubit.dart';

class HamBurgerMenuPage extends StatefulWidget {
  const HamBurgerMenuPage({super.key});

  @override
  State<HamBurgerMenuPage> createState() => _HamBurgerMenuPageState();
}

class _HamBurgerMenuPageState extends State<HamBurgerMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu',
              style: TextStyle(
                color: Colors.amber.shade500,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                context.go('/profile');
              },
              leading: const Icon(
                Icons.account_circle,
                size: 22,
              ),
              title: Text(
                'View Profile',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
            if (context.read<AuthenticationBloc>().state.user.isAdmin)
              ListTile(
                onTap: () {
                  context.read<ManageTableCubit>().initialize();
                  context.go('/ManageMenu');
                },
                leading: const Icon(
                  Icons.menu_book_rounded,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.manage('menu'),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                ),
              ),
            if (context.read<AuthenticationBloc>().state.user.isAdmin)
              ListTile(
                onTap: () {
                  context.read<ManageTableCubit>().initialize();
                  context.go('/users');
                },
                leading: const Icon(
                  Icons.manage_accounts_outlined,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.manage('user'),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                ),
              ),
            if (context.read<AuthenticationBloc>().state.user.isAdmin)
              ListTile(
                onTap: () {
                  context.read<ManageTableCubit>().initialize();
                  context.go('/ManageTable');
                },
                leading: const Icon(
                  Icons.tab_rounded,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.manage('res'),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                ),
              ),
            ListTile(
              onTap: () {
                context.read<AuthenticationBloc>().add(
                      AuthenticationLogoutRequest(),
                    );
                context.read<CartCubit>().reset();
              },
              leading: const Icon(
                Icons.logout,
                size: 22,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
