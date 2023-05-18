import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

import 'widgets/menu_item_about_section.dart';
import 'widgets/menu_item_app_bar.dart';
import 'widgets/menu_item_bottom_app_bar.dart';
import 'widgets/menu_item_info.dart';
import 'widgets/menu_item_quantity.dart';
import 'widgets/menu_item_title.dart';

class MenuItemPage extends StatefulWidget {
  final MenuItem? item;
  const MenuItemPage({super.key, required this.item});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MenuItemAppBar(
            imageUrl: widget.item!.imageUrl!,
          ),
          SliverPadding(
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuItemHeader(
                        menuItem: widget.item!,
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      MenuItemInfo(
                        menuItem: widget.item!,
                      ),
                      const Divider(),
                      MenuItemQuantity(
                        menuItem: widget.item!,
                        quantity: quantity,
                        callback: (value) {
                          setState(
                            () {
                              quantity = value;
                            },
                          );
                        },
                      ),
                      const Divider(),
                      MenuItemAbout(
                        menuItem: widget.item!,
                      ),
                    ],
                  )
                ],
              ),
            ),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
      bottomNavigationBar: MenuItemBottomAppBar(
        menuId: widget.item!.id,
        quantity: quantity,
        price: widget.item!.item!.price!,
      ),
    );
  }
}
