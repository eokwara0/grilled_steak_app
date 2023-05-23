import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/authentication/authentication.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu/menu_edit/cubit/menu_edit_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import 'package:grilled_steak_app/ui/splash/view/splash_page.dart';
import 'package:menu_repository/menu_repository.dart';

import 'cubit/menu_manage_cubit.dart';

class MenuManagePage extends StatefulWidget {
  const MenuManagePage({super.key});

  @override
  State<MenuManagePage> createState() => _MenuManagePageState();
}

class _MenuManagePageState extends State<MenuManagePage> {
  @override
  Widget build(BuildContext context) {
    // return ui
    return BlocProvider(
      create: (context) => MenuManageCubit(
        menuItemRepository: RepositoryProvider.of<MenuItemRepository>(context),
        menuRepository: RepositoryProvider.of<MenuRepository>(context),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocListener<MenuEditCubit, MenuEditState>(
              listener: (context, state) {
                if (state is MenuEditDelete) {
                  context.go('/success?message=Menu deleted successfully');
                } else if (state.isError) {
                  context.go(
                      '/error?message=An error occurred while deleting menu');
                }
              },
              child: BlocBuilder<MenuManageCubit, MenuManageState>(
                builder: (context, state_) {
                  return SliverAppBar(
                    pinned: true,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    leading: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        context.go('/');
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    title: state_.isLoaded || state_.isSubmitted
                        ? Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'Manage Menus',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          )
                        : null,
                    actions: state_.isLoaded || state_.isSubmitted
                        ? [
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: Colors.grey.shade400,
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: const Text(
                                      'Add Menu',
                                    ),
                                    onTap: () {
                                      context.read<MenuEditCubit>().add(
                                            Menu.empty(
                                              context
                                                  .read<AuthenticationBloc>()
                                                  .state
                                                  .user
                                                  .id,
                                            ),
                                          );
                                      context.go('/menuEdit');
                                    },
                                  ),
                                ];
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ]
                        : [],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BlocBuilder<MenuManageCubit, MenuManageState>(
                      buildWhen: (previous, current) {
                        return previous != current;
                      },
                      builder: (context, state) {
                        if (state.status == MenuManageStatus.error) {
                          return const SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: SplashPage(),
                          );
                        } else if (state.isLoaded || state.isSubmitted) {
                          return Column(
                            children: [
                              ...List.generate(
                                state.menus.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ExpansionTile(
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    leading: Image.network(
                                      width: 35,
                                      height: 35,
                                      state.menus[index].imageUrl!,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    title: Text(
                                      state.menus[index].title!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.red.shade400,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<MenuEditCubit>()
                                            .deleteMenu(state.menus[index]);
                                      },
                                    ),
                                    subtitle: Text(
                                      state.menus[index].summary!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          onPressed: () {
                                            context
                                                .read<MenuItemCubit>()
                                                .addItem(
                                                  MenuItem.empty(
                                                    context
                                                        .read<
                                                            AuthenticationBloc>()
                                                        .state
                                                        .user
                                                        .id,
                                                    state.menus[index].id,
                                                  ),
                                                );
                                            context.go('/menuItem/add');
                                          },
                                          child: const Text(
                                            'Add Item',
                                            style: TextStyle(
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (state.menusToItem.isNotEmpty)
                                        ...state.menusToItem[
                                                state.menus[index].title]!
                                            .map(
                                              (e) => ListTile(
                                                onTap: () {
                                                  context
                                                      .read<MenuItemCubit>()
                                                      .addItem(e);
                                                  context.go('/menuItem/edit');
                                                },
                                                isThreeLine: true,
                                                title: Text(
                                                  e.item!.title!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  e.item!.summary!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                leading: Image.network(
                                                  width: 50,
                                                  height: 50,
                                                  e.imageUrl!,
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<MenuItemCubit>()
                                                        .addItem(e);
                                                    context
                                                        .go('/menuItem/edit');
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: SplashPage(),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
