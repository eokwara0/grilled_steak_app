import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

import 'text_field_edit.dart';

class EditRecipeList extends StatefulWidget {
  const EditRecipeList({
    super.key,
    required this.recipeList,
    required this.onRecipeListChange,
  });

  final List<Recipe> recipeList;
  final Function(List<Recipe>) onRecipeListChange;

  @override
  State<EditRecipeList> createState() => _EditRecipeListState();
}

class _EditRecipeListState extends State<EditRecipeList> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    recipes = widget.recipeList;
  }

  @override
  Widget build(BuildContext context) {
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
                  setState(
                    () {
                      recipes.add(
                        Recipe(
                          title: 'Title ${recipes.length + 1}',
                          summary: 'summary',
                          instructions: 'Instructions',
                          quantity: 0.00,
                        ),
                      );

                      widget.onRecipeListChange(recipes);
                    },
                  );
                },
                child: const Text('Add Recipe'),
              ),
            ),
          ],
        ),
        ...recipes.map((e) {
          int index = recipes.indexOf(e);
          return EditRecipeWidget(
            recipe: e,
            recipeChanged: (value) {
              recipes.replaceRange(
                index,
                index + 1,
                [value],
              );
              widget.onRecipeListChange(recipes);
            },
            removeRecipe: (value) {
              setState(
                () {
                  recipes.remove(value);
                  widget.onRecipeListChange(recipes);
                },
              );
            },
          );
        }).toList()
      ],
    );
  }
}

class EditRecipeWidget extends StatelessWidget {
  EditRecipeWidget({
    super.key,
    required this.recipe,
    this.removeRecipe,
    this.recipeChanged,
  });

  Recipe recipe;
  final Function(Recipe)? removeRecipe;
  final Function(Recipe)? recipeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          key: Key(
            '${recipe.title}',
          ),

          // callback functions
          dismissThresholds: const {
            DismissDirection.endToStart: .95,
          },
          onDismissed: (direction) {
            removeRecipe!(recipe);
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
              '${recipe.title}',
            ),
            shape: const RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            children: [
              EditTextField(
                maxLines: 1,
                maxLength: 30,
                onFieldSubmitted: (data) {
                  recipe = recipe.copyWith(title: data);
                  recipeChanged!(recipe);
                },
                onTapOutside: (p0) {
                  recipeChanged!(recipe);
                },
                onEditingComplete: () {
                  recipeChanged!(recipe);
                },
                onChanged: (value) {
                  recipe = recipe.copyWith(title: value);
                },
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                hint: '${recipe.title}',
                label: 'Title',
              ),
              EditTextField(
                maxLength: 100,
                maxLines: 1,
                onFieldSubmitted: (data) {
                  recipe = recipe.copyWith(summary: data);
                  recipeChanged!(recipe);
                },
                onTapOutside: (p0) {
                  recipeChanged!(recipe);
                },
                onEditingComplete: () {
                  recipeChanged!(recipe);
                },
                onChanged: (value) {
                  recipe = recipe.copyWith(summary: value);
                },
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                label: 'Summary',
                hint: '${recipe.summary}',
              ),
              EditTextField(
                maxLength: 10,
                maxLines: 1,
                onTapOutside: (p0) {
                  recipeChanged!(recipe);
                },
                onEditingComplete: () {
                  recipeChanged!(recipe);
                },
                onFieldSubmitted: (data) {
                  recipe = recipe.copyWith(quantity: double.tryParse(data));
                  recipeChanged!(recipe);
                },
                onChanged: (value) {
                  recipe = recipe.copyWith(
                    quantity: double.tryParse(value),
                  );
                },
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                label: 'Quantity',
                hint: '${recipe.quantity}',
              ),
              EditTextField(
                maxLines: 1,
                maxLength: 20,
                onFieldSubmitted: (data) {
                  recipe = recipe.copyWith(units: data);
                  recipeChanged!(recipe);
                },
                onTapOutside: (p0) {
                  recipeChanged!(recipe);
                },
                onEditingComplete: () {
                  recipeChanged!(recipe);
                },
                onChanged: (value) {
                  recipe = recipe.copyWith(units: value);
                },
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                label: 'units',
                hint: recipe.unit ?? 'Enter units of measure',
              ),
              EditTextField(
                maxLines: 1,
                maxLength: 400,
                onFieldSubmitted: (data) {
                  recipe = recipe.copyWith(instructions: data);
                  recipeChanged!(recipe);
                },
                onTapOutside: (p0) {
                  recipeChanged!(recipe);
                },
                onEditingComplete: () {
                  recipeChanged!(recipe);
                },
                onChanged: (value) {
                  recipe = recipe.copyWith(instructions: value);
                },
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                label: 'Instructions',
                hint: 'Enter Instructions',
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
        )
      ],
    );
  }
}
