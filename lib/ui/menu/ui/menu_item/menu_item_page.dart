import 'package:flutter/material.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/widgets/learn_more_page_nutriton.dart';
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

class _MenuItemPageState extends State<MenuItemPage>
    with SingleTickerProviderStateMixin {
  late int quantity;
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    quantity = 1;
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, boolean) {
          return [
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
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                      ],
                    )
                  ],
                ),
              ),
              padding: const EdgeInsets.all(20),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 40.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.numbers_outlined,
                      color: Colors.grey[400],
                    ),
                    Text(
                      'Nutrition values',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    )
                  ],
                )
              ])),
            ),
            NutritionGrid(menuItem: widget.item!),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black54,
                        indicatorPadding: const EdgeInsets.all(4),
                        labelPadding: const EdgeInsets.all(3),
                        indicator: BoxDecoration(
                          color: Colors.amber,
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tabs: const [
                          Tab(
                            height: 40,
                            text: 'Instructions',
                          ),
                          Tab(
                            // icon: Icon(Icons.search),
                            height: 40,
                            text: 'Ingredients',
                          ),
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              padding: const EdgeInsets.all(30),
              children: [
                ...tileInstructions(
                  widget.item!.item!.instructions!,
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(30),
              children: [
                ...tileIngredients(
                  widget.item!.item!.recipe!,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MenuItemBottomAppBar(
        menuId: widget.item!.id,
        quantity: quantity,
        price: widget.item!.item!.price!,
      ),
    );
  }

  List<Widget> tileInstructions(String instructions) {
    List<String> lOfInstructions = instructions.split('\n');
    return lOfInstructions
        .where((element) => element != "")
        .map(
          (e) => Column(
            children: [
              ListTile(
                title: Text(e),
                textColor: Colors.grey.shade700,
              ),
              const Divider()
            ],
          ),
        )
        .toList();
  }

  List<Widget> tileIngredients(List<Recipe> recipes) {
    return recipes
        .map((e) => Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 30,
                      color: Colors.grey[700],
                    ),
                  ),
                  splashColor: Colors.blue,
                  title: Text(
                    e.title!,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    e.summary!,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    '${e.quantity?.toStringAsPrecision(2)} ${e.unit}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ))
        .toList();
  }
}
