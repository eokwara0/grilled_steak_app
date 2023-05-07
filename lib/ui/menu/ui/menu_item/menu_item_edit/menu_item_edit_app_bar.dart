import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/menu_item_edit_bloc.dart';

class MenuItemEditAppBar extends StatelessWidget {
  const MenuItemEditAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
      builder: (context, state) {
        final Object image = !state.fileIsNull
            ? FileImage(state.file!)
            : NetworkImage(state.menuItem.imageUrl!);
        return SliverAppBar(
          expandedHeight: 200,
          automaticallyImplyLeading: false,
          leading: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              onTap: () {
                context.go('/');
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            '# ${state.menuItem.item?.title}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          flexibleSpace: Blur(
            blur: 0,
            blurColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          actions: [
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Chip(
                label: const Text(
                  'active',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: state.menuItem.active!
                    ? Colors.amber
                    : Colors.grey.shade400,
              ),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          pinned: true,
        );
      },
    );
  }
}
