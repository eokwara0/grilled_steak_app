import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_item_cubit.dart';

import '../../../../../authentication/authentication.dart';
import '../cubit/search_bottom_sheet_cubit.dart';
import 'asset_image.dart';
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
        return ListView.builder(
          cacheExtent: 10,
          controller: controller,
          itemCount: state.result.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  isThreeLine: true,
                  enableFeedback: true,
                  leading: const AssetImageCover(url: 'images/back.jpg'),
                  title: Text(state.result[index].item.title),
                  subtitle: Text(state.result[index].item.summary),
                  trailing: role ? const EditIcon() : null,
                  onTap: () {
                    context.read<MenuItemCubit>().addItem(state.result[index]);
                    context.go('/menuItem');
                  },
                ),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
