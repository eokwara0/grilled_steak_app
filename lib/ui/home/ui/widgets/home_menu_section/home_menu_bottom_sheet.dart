import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

import '../../../../../authentication/authentication.dart';
import '../../../../widgets/persistant_header_drag.dart';

class HomeMenuSectionBottomSheet extends StatelessWidget {
  const HomeMenuSectionBottomSheet({super.key, required List<Menu> menus})
      : _menus = menus;

  final List<Menu> _menus;
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
                  ..._menus.map(
                    (e) => Column(
                      children: [
                        ListTile(
                            onTap: () {
                              /** */
                            },
                            leading: Image.network(
                              e.imageUrl!,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                              scale: 1.2,
                            ),
                            title: Text(e.title!),
                            subtitle: Text(e.summary!),
                            trailing: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user
                                    .isAdmin
                                ? InkWell(
                                    onTap: () {},
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
