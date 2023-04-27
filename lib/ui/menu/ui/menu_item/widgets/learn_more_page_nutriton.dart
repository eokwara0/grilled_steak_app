import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class NutritionGrid extends StatelessWidget {
  const NutritionGrid({
    super.key,
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverGrid.count(
        mainAxisSpacing: 10,
        childAspectRatio: 3,
        crossAxisCount: 2,
        children: [
          Row(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.local_florist_sharp,
                      color: Colors.amber.shade600,
                      size: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                    '${menuItem.item.nutrition.carbs} carbs',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.sentiment_neutral_outlined,
                      color: Colors.amber.shade600,
                      size: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                    '${menuItem.item.nutrition.protein} protein',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.local_fire_department_outlined,
                      color: Colors.amber.shade600,
                      size: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                    '${menuItem.item.nutrition.calories} Kal',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.egg_alt_outlined,
                      color: Colors.amber.shade600,
                      size: 30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                    '${menuItem.item.nutrition.fat} fat',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
    );
  }
}
