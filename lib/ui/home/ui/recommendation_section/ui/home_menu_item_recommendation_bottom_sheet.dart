import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_repository/menu_repository.dart';

import '../../../../../authentication/bloc/authentication_bloc.dart';
import '../../../../menu/cubit/menu_item_cubit.dart';
import '../../../../widgets/persistant_header_drag.dart';

class HomeMenuItemRecommendationBottomSheet extends StatelessWidget {
  const HomeMenuItemRecommendationBottomSheet({
    required List<MenuItem> items,
    super.key,
  }) : _menuItems = items;

  final List<MenuItem> _menuItems;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: false,
      builder: (context, scroll) {
        return CustomScrollView(
          controller: scroll,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: PersistanceHeaderDragDelegate(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ..._menuItems.map(
                    (e) => Column(
                      children: [
                        ListTile(
                            onTap: () {
                              context.read<MenuItemCubit>().addItem(e);
                              context.go('/menuItem');
                            },
                            leading: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.network(
                                e.imageUrl!,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                scale: 1.2,
                              ),
                            ),
                            title: Text(e.item!.title!),
                            subtitle: Text(e.item!.summary!),
                            trailing: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user
                                    .isAdmin
                                ? InkWell(
                                    onTap: () {
                                      context.read<MenuItemCubit>().addItem(e);
                                      context.go('/menuItem/edit');
                                    },
                                    child: const Icon(
                                      Icons.edit_note_outlined,
                                    ),
                                  )
                                : null),
                        const Divider(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
