import 'package:flutter/material.dart';
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
                            widget.menuItem.item.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            widget.menuItem.item.summary,
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
                    labelColor: Colors.black38,
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
                padding: EdgeInsets.all(20),
                children: [
                  Text('hi'),
                ],
              ),
              ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Text('hi'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

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
