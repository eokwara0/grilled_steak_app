import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

import '../cubit/menu_item_cubit.dart';
import 'bloc/menu_item_edit_bloc.dart';
import 'ui/menu_item_edit_body.dart';

class MenuItemEditPage extends StatelessWidget {
  const MenuItemEditPage({
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
                      'Update',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  // Spacer(),
                  TextButton(
                    onPressed: () {
                      context.read<MenuItemEditBloc>().add(
                            const MenuItemDeleteEvent(),
                          );
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
