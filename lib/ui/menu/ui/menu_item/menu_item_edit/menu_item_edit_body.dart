import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/menu_item_edit_bloc.dart';
import 'menu_item_edit_app_bar.dart';
import 'menu_item_edit_error.dart';
import 'menu_item_edit_instructions.dart';
import 'menu_item_edit_nutrition.dart';
import 'menu_item_edit_success.dart';
import 'menu_item_edit_upload.dart';
import 'menu_item_recipe_edit.dart';
import 'text_field_edit.dart';

class MenuItemEditBody extends StatelessWidget {
  const MenuItemEditBody({
    super.key,
    required this.bottomAppBar,
  });

  final Widget bottomAppBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
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
                return bottomAppBar;
              },
            ),
          ),
          body: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state.isError) {
                return const MenuItemEditErrorPage(message: 'An error occured');
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
                  const MenuItemEditAppBar(),
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
                              const MenuItemEditUploadImage(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
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
                                  context
                                      .read<MenuItemEditBloc>()
                                      .add(MenuItemSummaryChangedEvent(value));
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
                                  context
                                      .read<MenuItemEditBloc>()
                                      .add(MenuItemContentChangedEvent(value));
                                },
                                label: 'Content',
                                hint: state.menuItem.item!.content!,
                              ),
                              const Divider(),
                              EditTextField(
                                onChanged: (value) {
                                  context
                                      .read<MenuItemEditBloc>()
                                      .add(MenuItemQuantityChangedEvent(value));
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
                              const Padding(
                                padding: EdgeInsets.all(40),
                              ),
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
    );
  }
}
