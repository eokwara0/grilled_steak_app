import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/app/authentication/authentication.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_cubit.dart';
import 'package:grilled_steak_app/ui/widgets/splash_page.dart';
import 'package:menu_repository/menu_repository.dart';

import '../menu_item/cubit/menu_item_cubit.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            leading: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.grey.shade500,
              ),
              onPressed: () {
                context.go('/');
              },
            ),
            title: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state.isLoaded) {
                  return SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            state.menu.imageUrl!,
                            width: 30,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.menu.title!} Menu',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            actions: context.read<AuthenticationBloc>().state.user.isAdmin
                ? [
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.grey.shade500,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: const Text('Manage Menus'),
                            onTap: () {
                              context.go('/manageMenu');
                            },
                          )
                        ];
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                    )
                  ]
                : [],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state.isLoaded) {
                  return SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Text(
                          '${state.items.length} Items',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${state.menu.title!}s',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.isError) {
                  return SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 300,
                            child: const Text('An error occured'))
                      ],
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 300,
                          child: const SplashPage(),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                return SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  childAspectRatio: .58,
                  children: [
                    ...List.generate(
                      state.items.length,
                      (index) {
                        return LongCard(
                          item: state.items[index],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class LongCard extends StatelessWidget {
  const LongCard({super.key, required this.item});
  final MenuItem item;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink(
            width: double.infinity,
            height: 210,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
            child: InkWell(
              onTap: () {
                context.read<MenuItemCubit>().addItem(item);
                context.go('/menuItem');
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.item!.title!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'R${item.item!.price!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: Colors.grey.shade400,
                        ),
                        Text('${item.item?.nutrition?.calories}Kal'),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
