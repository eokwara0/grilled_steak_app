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
      children: [
        Row(
          children: [
            const Text(
              'About',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) => MenuItemLearnMore(
                    menuItem: menuItem,
                  ),
                );
              },
              child: Tooltip(
                message: 'learn more',
                child: Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
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
                  wordSpacing: 3,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
