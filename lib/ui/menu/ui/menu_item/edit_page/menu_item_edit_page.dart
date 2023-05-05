import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_item_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/edit_page/menu_item_edit_error.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/edit_page/menu_item_edit_instructions.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/edit_page/menu_item_edit_success.dart';
import 'package:menu_repository/menu_repository.dart';

import 'bloc/menu_item_edit_bloc.dart';
import 'menu_item_edit_nutrition.dart';
import 'menu_item_recipe_edit.dart';
import 'text_field_edit.dart';

class MenuItemEditPage extends StatelessWidget {
  const MenuItemEditPage({
    super.key,
    required item,
  }) : _menuItem = item;

  final MenuItem _menuItem;

  // recipe list

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuItemEditBloc(
        item: context.read<MenuItemCubit>().state.item,
        menuItemRepo: RepositoryProvider.of<MenuItemRepository>(context),
      ),
      child: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 90,
              child: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
                builder: (context, state) {
                  if (state.isError) {
                    return Container();
                  } else if (state.isDeleted) {
                    return Container();
                  } else if (state.isSubmitted) {
                    return Container();
                  }
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
            body: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                if (state.isError) {
                  return const MenuItemEditErrorPage(
                      message: 'An error occured');
                } else if (state.isSubmitted) {
                  return const MenuItemEditSuccess(
                    message: 'Menu Item has been successfully updated',
                  );
                } else if (state.isDeleted) {
                  return const MenuItemEditSuccess(
                    message: 'Menu Item has been successfully deleted',
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.go('/');
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      title: Text(
                        '# ${state.menuItem.item?.title}',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
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
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      pinned: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Switch(
                                  activeColor: Colors.amber,
                                  value: state.menuItem.active!,
                                  onChanged: (bol) {
                                    context.read<MenuItemEditBloc>().add(
                                          MenuItemActiveEditEvent(
                                            !state.menuItem.active!,
                                          ),
                                        );
                                  },
                                ),
                                EditTextField(
                                  onChanged: (value) {
                                    context
                                        .read<MenuItemEditBloc>()
                                        .add(MenuItemTitleChangedEvent(value));
                                  },
                                  maxLength: 35,
                                  maxLines: 1,
                                  label: "Title",
                                  hint: state.menuItem.item!.title!,
                                ),
                                const Divider(),
                                EditTextField(
                                  onChanged: (value) {
                                    context.read<MenuItemEditBloc>().add(
                                        MenuItemSummaryChangedEvent(value));
                                  },
                                  maxLines: 1,
                                  maxLength: 150,
                                  label: 'Summary',
                                  hint: state.menuItem.item!.summary!,
                                ),
                                const Divider(),
                                EditTextField(
                                  maxLength: 700,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    context.read<MenuItemEditBloc>().add(
                                        MenuItemContentChangedEvent(value));
                                  },
                                  label: 'Content',
                                  hint: state.menuItem.item!.content!,
                                ),
                                const Divider(),
                                EditTextField(
                                  onChanged: (value) {
                                    context.read<MenuItemEditBloc>().add(
                                        MenuItemQuantityChangedEvent(value));
                                  },
                                  maxLines: 1,
                                  maxLength: 10,
                                  label: 'Quantity',
                                  hint: '${state.menuItem.item?.quantity}',
                                ),
                                const Divider(),
                                EditTextField(
                                  onChanged: (value) {
                                    context
                                        .read<MenuItemEditBloc>()
                                        .add(MenuItemPriceChangedEVent(value));
                                  },
                                  maxLength: 20,
                                  maxLines: 1,
                                  label: 'Price',
                                  hint: '${state.menuItem.item?.price}',
                                ),
                                const Divider(),
                                const MenuItemEditNutrition(),
                                const Divider(),
                                const EditRecipeList(),
                                const Divider(),
                                const EditMenuItemInstructions(),
                                const Padding(padding: EdgeInsets.all(40)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
