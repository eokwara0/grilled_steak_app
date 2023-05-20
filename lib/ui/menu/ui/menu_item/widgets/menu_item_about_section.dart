import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

import 'menu_item_learn_more_widget.dart';

class MenuItemAbout extends StatelessWidget {
  const MenuItemAbout({
    super.key,
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'About',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.info_outline_rounded,
              color: Colors.amber[600],
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                '${menuItem.item?.content}'
                    .replaceAll('\n', '')
                    .replaceAll('  ', '')
                  ..trim(),
                style: const TextStyle(
                  height: 1.5,
                  wordSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
