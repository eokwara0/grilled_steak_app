import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuItemHeader extends StatelessWidget {
  const MenuItemHeader({
    super.key,
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            menuItem.item!.title!,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  menuItem.item!.summary!,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        ],
      ),
    );
  }
}
