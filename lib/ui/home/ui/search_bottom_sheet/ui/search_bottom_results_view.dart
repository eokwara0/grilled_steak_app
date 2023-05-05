import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_item_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/edit_page/bloc/menu_item_edit_bloc.dart';
import 'package:grilled_steak_app/ui/widgets/persistant_header_drag.dart';

import '../../../../../authentication/authentication.dart';
import '../cubit/search_bottom_sheet_cubit.dart';
import 'edit_icon.dart';

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
    required this.search,
    required this.controller,
  });

  final String search;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    bool role = context.read<AuthenticationBloc>().state.user.isAdmin;
    return BlocBuilder<SearchBottomSheetCubit, SearchBottomSheetState>(
      builder: (context, state) {
        return CustomScrollView(
          controller: controller,
          slivers: [
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: PersistanceHeaderDragDelegate(),
            ),

            // list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.result.length,
                (context, index) => Column(
                  children: [
                    ListTile(
                      leading: Image.network(
                        state.result[index].imageUrl!,
                        fit: BoxFit.cover,
                      ),
                      title: Text(state.result[index].item!.title!),
                      subtitle: Text(state.result[index].item!.summary!),
                      trailing: role
                          ? EditIcon(
                              onPressed: () {
                                context.read<MenuItemCubit>().addItem(
                                      state.result[index],
                                    );

                                context.go('/menuItem/edit');
                              },
                            )
                          : null,
                      onTap: () {
                        context
                            .read<MenuItemCubit>()
                            .addItem(state.result[index]);
                        context.go('/menuItem');
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
