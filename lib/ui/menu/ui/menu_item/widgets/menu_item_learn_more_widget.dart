import 'package:flutter/material.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/widgets/learn_more_page_nutriton.dart';
import 'package:grilled_steak_app/ui/widgets/persistant_header_drag.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuItemLearnMore extends StatefulWidget {
  const MenuItemLearnMore({
    super.key,
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  State<MenuItemLearnMore> createState() => _MenuItemLearnMoreState();
}

class _MenuItemLearnMoreState extends State<MenuItemLearnMore>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: false,
      builder: (context, scroll) {
        return NestedScrollView(
          // controller: scroll,
          headerSliverBuilder: (context, boo) {
            return <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: PersistanceHeaderDragDelegate(),
              ),

              //  Header section
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.menuItem.item!.summary!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            widget.menuItem.item!.title!,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Nutrition
              NutritionGrid(menuItem: widget.menuItem),

              // app bar headers
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverAppBar(
                  backgroundColor: Colors.grey.shade300,
                  shape: const StadiumBorder(),
                  toolbarHeight: 0,
                  bottom: TabBar(
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
                    controller: _controller,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  ...tileInstructions(widget.menuItem.item!.instructions!)
                ],
              ),
              ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  ...tileIngredients(widget.menuItem.item!.recipe!),
                ],
              ),
            ],
          ),
        );
      },
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
        .map(
          (e) => Column(
            children: [
              ListTile(
                splashColor: Colors.blue,
                title: Text(
                  e.title!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 19,
                  ),
                ),
                subtitle: Text(
                  e.summary!,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
                trailing: Text(
                  '${e.quantity?.toStringAsPrecision(2)} ${e.unit}',
                ),
              ),
              const Divider(),
            ],
          ),
        )
        .toList();
  }
}
