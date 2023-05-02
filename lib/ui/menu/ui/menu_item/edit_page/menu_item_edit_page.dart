import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/edit_page/menu_item_edit_instructions.dart';
import 'package:menu_repository/menu_repository.dart';

import 'bloc/menu_item_edit_bloc.dart';
import 'menu_item_edit_nutrition.dart';
import 'menu_item_recipe_edit_widget.dart';
import 'text_field_edit.dart';

class MenuItemEditPage extends StatefulWidget {
  const MenuItemEditPage({super.key, required item}) : _menuItem = item;

  final MenuItem _menuItem;

  @override
  State<MenuItemEditPage> createState() => _MenuItemEditPageState();
}

class _MenuItemEditPageState extends State<MenuItemEditPage> {
  late List<Recipe> recipeList;
  late List<String> instructions;
  late bool? active;
  late Nutrition nutrition;

  @override
  void initState() {
    super.initState();

    // recipe list

    recipeList = List.of(widget._menuItem.item!.recipe ?? []);
    instructions = widget._menuItem.item!.instructions!.split('\n');
    active = widget._menuItem.active ?? false;
    nutrition = widget._menuItem.item!.nutrition!;

    // recipe list
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuItemEditBloc(
        item: widget._menuItem,
        menuItemRepo: RepositoryProvider.of<MenuItemRepository>(context),
      ),
      child: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 90,
              child: BottomAppBar(
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
                        // context
                        //     .read<MenuItemEditBloc>()
                        //     .add(const MenuItemSubmitEvent(''));
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
              ),
            ),
            body: BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
              builder: (context, state) {
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
                        '# ${widget._menuItem.item?.title}',
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
                            backgroundColor:
                                active! ? Colors.amber : Colors.grey.shade400,
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
                                  value: active!,
                                  onChanged: (bol) {
                                    setState(
                                      () {
                                        active = !active!;
                                        context.read<MenuItemEditBloc>().add(
                                              MenuItemActiveEditEvent(active!),
                                            );
                                      },
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
                                  hint: widget._menuItem.item!.title!,
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
                                  hint: widget._menuItem.item!.summary!,
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
                                  hint: widget._menuItem.item!.content!,
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
                                  hint: '${widget._menuItem.item?.quantity}',
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
                                  hint: '${widget._menuItem.item?.price}',
                                ),
                                const Divider(),
                                MenuItemEditNutrition(
                                  onChange: (value) {
                                    nutrition = value;
                                    context.read<MenuItemEditBloc>().add(
                                        MenuItemNutritionChangedEvent(value));
                                  },
                                  nutrition: nutrition,
                                ),
                                const Divider(),
                                EditRecipeList(
                                  recipeList: recipeList,
                                  onRecipeListChange: (recipe) {
                                    recipeList = recipe;
                                    context.read<MenuItemEditBloc>().add(
                                        MenuItemRecipeChangedEvent(recipe));
                                  },
                                ),
                                const Divider(),
                                EditMenuItemInstructions(
                                  instructions: instructions,
                                  instructionsChanged: (value) {
                                    instructions = value;

                                    context.read<MenuItemEditBloc>().add(
                                          MenuItemInstructionsChangedEvent(
                                            value.join('\n'),
                                          ),
                                        );
                                  },
                                ),
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
