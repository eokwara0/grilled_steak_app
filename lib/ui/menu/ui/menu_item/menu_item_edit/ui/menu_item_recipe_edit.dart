import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

import '../bloc/menu_item_edit_bloc.dart';
import 'text_field_edit.dart';

class EditRecipeList extends StatefulWidget {
  const EditRecipeList({
    super.key,
  });

  @override
  State<EditRecipeList> createState() => _EditRecipeListState();
}

class _EditRecipeListState extends State<EditRecipeList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
      key: const ValueKey('RecipeEditKey'),
      buildWhen: (previous, current) {
        return true;
      },
      builder: (context, state) {
        List<Recipe> recipes = state.menuItem.item!.recipe!;
        return ExpansionTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          title: Text(
            'Recipes',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextButton(
                    onPressed: () {
                      recipes.add(
                        Recipe(
                          title:
                              'Title ${state.menuItem.item!.recipe!.length + 1}',
                          summary: 'summary',
                          instructions: 'Instructions',
                          quantity: 0.00,
                          units: "",
                        ),
                      );
                      context.read<MenuItemEditBloc>().add(
                            MenuItemRecipeChangedEvent(recipes),
                          );
                      setState(() {});
                    },
                    child: const Text('Add Recipe'),
                  ),
                ),
              ],
            ),
            ...recipes.map(
              (e) {
                int index = recipes.indexOf(e);
                return Column(
                  children: [
                    Dismissible(
                      key: Key(
                        '${state.menuItem.item!.recipe![index].title}',
                      ),

                      // callback functions
                      dismissThresholds: const {
                        DismissDirection.endToStart: .95,
                      },
                      onDismissed: (direction) {
                        recipes.remove(e);
                        context.read<MenuItemEditBloc>().add(
                              MenuItemRecipeChangedEvent(recipes),
                            );
                        setState(() {});
                      },
                      confirmDismiss: (direction) async {
                        if (direction.index == 2) {
                          return true;
                        }
                        return false;
                      },

                      // behaviour and dismissal direction
                      behavior: HitTestBehavior.translucent,
                      direction: DismissDirection.endToStart,

                      background: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // child
                      child: ExpansionTile(
                        textColor: Colors.amber,
                        title: Text(
                          '${recipes[index].title}',
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        children: [
                          EditTextField(
                            maxLines: 1,
                            maxLength: 30,
                            onChanged: (value) {
                              Recipe recipe = e.copyWith(title: value);
                              recipes.replaceRange(index, index + 1, [recipe]);
                              context.read<MenuItemEditBloc>().add(
                                    MenuItemRecipeChangedEvent(recipes),
                                  );
                            },
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            hint:
                                '${state.menuItem.item!.recipe![index].title}',
                            label: 'Title',
                          ),
                          EditTextField(
                            maxLength: 100,
                            maxLines: 1,
                            onChanged: (value) {
                              Recipe recipe = e.copyWith(
                                summary: value,
                              );
                              recipes.replaceRange(
                                index,
                                index + 1,
                                [recipe],
                              );
                              context.read<MenuItemEditBloc>().add(
                                    MenuItemRecipeChangedEvent(recipes),
                                  );
                            },
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            label: 'Summary',
                            hint: '${recipes[index].summary}',
                          ),
                          EditTextField(
                            maxLength: 10,
                            maxLines: 1,
                            onChanged: (value) {
                              Recipe recipe = e.copyWith(
                                quantity: double.tryParse(value),
                              );

                              recipes.replaceRange(
                                index,
                                index + 1,
                                [recipe],
                              );
                              context.read<MenuItemEditBloc>().add(
                                    MenuItemRecipeChangedEvent(recipes),
                                  );
                            },
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            label: 'Quantity',
                            hint: '${recipes[index].quantity}',
                          ),
                          EditTextField(
                            maxLines: 1,
                            maxLength: 20,
                            onChanged: (value) {
                              Recipe recipe = e.copyWith(units: value);
                              recipes.replaceRange(
                                index,
                                index + 1,
                                [recipe],
                              );

                              context.read<MenuItemEditBloc>().add(
                                    MenuItemRecipeChangedEvent(recipes),
                                  );
                            },
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            label: 'units',
                            hint: recipes[index].unit ?? 'Enter Units',
                          ),
                          EditTextField(
                            maxLines: 1,
                            maxLength: 400,
                            onChanged: (value) {
                              Recipe recipe = e.copyWith(instructions: value);
                              recipes.replaceRange(
                                index,
                                index + 1,
                                [recipe],
                              );
                              context.read<MenuItemEditBloc>().add(
                                    MenuItemRecipeChangedEvent(recipes),
                                  );
                            },
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            label: 'Instructions',
                            hint: recipes[index].instructions ??
                                'Enter you instructions',
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    )
                  ],
                );
              },
            ).toList()
          ],
        );
      },
    );
  }
}
