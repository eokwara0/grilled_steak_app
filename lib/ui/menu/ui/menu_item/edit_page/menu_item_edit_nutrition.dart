import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

import 'text_field_edit.dart';

class MenuItemEditNutrition extends StatefulWidget {
  const MenuItemEditNutrition({
    super.key,
    required this.nutrition,
    this.onChange,
  });

  final Nutrition nutrition;
  final Function(Nutrition value)? onChange;

  @override
  State<MenuItemEditNutrition> createState() => _MenuItemEditNutritionState();
}

class _MenuItemEditNutritionState extends State<MenuItemEditNutrition> {
  late Nutrition nut;

  @override
  void initState() {
    super.initState();
    nut = widget.nutrition;
  }

  @override
  Widget build(BuildContext context) {
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
              nut = nut.copyWith(calories: value);
              widget.onChange!(nut);
            },
            label: 'Calories',
            hint: '${nut.calories}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: EditTextField(
            onChanged: (value) {
              nut = nut.copyWith(carbs: value);
              widget.onChange!(nut);
            },
            label: 'Carbs',
            hint: '${nut.carbs}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: EditTextField(
            onChanged: (value) {
              nut = nut.copyWith(protein: value);
              widget.onChange!(nut);
            },
            label: 'Protein',
            hint: '${nut.protein}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: EditTextField(
            onChanged: (value) {
              nut = nut.copyWith(fat: value);
              widget.onChange!(nut);
            },
            label: 'Fat',
            hint: '${nut.fat}',
          ),
        ),
      ],
    );
  }
}
