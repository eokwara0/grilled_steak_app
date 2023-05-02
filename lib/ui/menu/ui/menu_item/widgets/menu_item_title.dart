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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menuItem.item!.title!,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                menuItem.item!.summary!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ],
    );
  }
}
