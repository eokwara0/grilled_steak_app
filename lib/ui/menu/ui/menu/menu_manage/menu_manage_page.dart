import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import 'package:grilled_steak_app/ui/splash/view/splash_page.dart';

import 'cubit/menu_manage_cubit.dart';

class MenuManagePage extends StatelessWidget {
  const MenuManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // make a call to refresh data
    context.read<MenuManageCubit>().initialize();

    // return ui
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<MenuManageCubit, MenuManageState>(
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
                title: state_.isLoaded
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
                actions: state_.isLoaded
                    ? [
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: Colors.grey.shade400,
                          ),
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                child: Text(
                                  'Add Menu',
                                ),
                              ),
                              const PopupMenuItem(
                                child: Text(
                                  'Edit Menu',
                                ),
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
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocBuilder<MenuManageCubit, MenuManageState>(
                    buildWhen: (previous, current) {
                      return previous.status != current.status;
                    },
                    builder: (context, state) {
                      if (state.status == Status.error) {
                        return const SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: SplashPage(),
                        );
                      } else if (state.status == Status.loaded) {
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
                                        onPressed: () {},
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
                                                  context.go('/menuItem/edit');
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
    );
  }
}
