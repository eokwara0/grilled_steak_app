import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuItemInfo extends StatelessWidget {
  const MenuItemInfo({
    super.key,
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.all(3),
              ),
              Text(
                menuItem.item.prep,
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.adjust_sharp,
              color: Colors.grey,
              size: 10,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.local_fire_department_outlined,
                color: Colors.grey,
              ),
              Text(
                '${menuItem.item.nutrition.calories}Kal',
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.adjust_sharp,
              color: Colors.grey,
              size: 10,
            ),
          ),
        ],
      ),
    );
  }
}
