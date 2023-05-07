import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

import '../cubit/menu_item_cubit.dart';
import '../menu_item_edit/bloc/menu_item_edit_bloc.dart';
import '../menu_item_edit/menu_item_edit_body.dart';

class MenuItemAddPage extends StatelessWidget {
  const MenuItemAddPage({
    super.key,
  });

  // recipe list

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuItemEditBloc(
        // properties
        item: context.read<MenuItemCubit>().state.item,
        menuItemRepo: RepositoryProvider.of<MenuItemRepository>(context),
        menuRepo: RepositoryProvider.of<MenuRepository>(context),

        //
      ),

      // child
      child: MenuItemEditBody(
        bottomAppBar: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
          builder: (context, state) {
            return BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<MenuItemEditBloc>()
                          .add(const MenuItemSubmitEvent(''));
                    },
                    child: const Text(
                      'Add New Item',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
