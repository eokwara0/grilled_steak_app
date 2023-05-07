import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_item_edit_bloc.dart';
import 'text_field_edit.dart';

class MenuItemEditNutrition extends StatelessWidget {
  const MenuItemEditNutrition({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
      builder: (context, state) {
        return ExpansionTile(
          textColor: Colors.amber,
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nutrition',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: EditTextField(
                onChanged: (value) {
                  final nutrition = state.menuItem.item!.nutrition!.copyWith(
                    calories: value,
                  );
                  context.read<MenuItemEditBloc>().add(
                        MenuItemNutritionChangedEvent(
                          nutrition,
                        ),
                      );
                },
                maxLength: 20,
                maxLines: 1,
                label: 'Calories',
                hint: '${state.menuItem.item!.nutrition!.calories}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: EditTextField(
                onChanged: (value) {
                  final nutrition = state.menuItem.item!.nutrition!.copyWith(
                    carbs: value,
                  );
                  context.read<MenuItemEditBloc>().add(
                        MenuItemNutritionChangedEvent(
                          nutrition,
                        ),
                      );
                },
                maxLength: 20,
                maxLines: 1,
                label: 'Carbs',
                hint: '${state.menuItem.item!.nutrition!.carbs}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: EditTextField(
                onChanged: (value) {
                  final nutrition = state.menuItem.item!.nutrition!.copyWith(
                    protein: value,
                  );
                  context.read<MenuItemEditBloc>().add(
                        MenuItemNutritionChangedEvent(
                          nutrition,
                        ),
                      );
                },
                maxLength: 20,
                maxLines: 1,
                label: 'Protein',
                hint: '${state.menuItem.item!.nutrition!.protein}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: EditTextField(
                onChanged: (value) {
                  final nutrition = state.menuItem.item!.nutrition!.copyWith(
                    fat: value,
                  );
                  context.read<MenuItemEditBloc>().add(
                        MenuItemNutritionChangedEvent(
                          nutrition,
                        ),
                      );
                },
                maxLength: 20,
                maxLines: 1,
                label: 'Fat',
                hint: '${state.menuItem.item!.nutrition!.fat}',
              ),
            ),
          ],
        );
      },
    );
  }
}
