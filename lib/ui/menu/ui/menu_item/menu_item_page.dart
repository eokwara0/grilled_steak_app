import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuItemPage extends StatefulWidget {
  final MenuItem? item;
  const MenuItemPage({super.key, required this.item});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            // stretch: true,
            expandedHeight: 400,
            collapsedHeight: 200,
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                radius: 20,
                child: IconButton(
                  enableFeedback: true,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
            ),
            // leading: IconButton(
            //   onPressed: () {
            //     context.go('/');
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //     color: Colors.white,
            //     size: 20,
            //   ),
            //   style: IconButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     foregroundColor: Colors.white,
            //     focusColor: Colors.white,
            //   ),
            // ),
            flexibleSpace: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('http://localhost:3000/mush.webp'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SliverPadding(
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 1, (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item?.item.title,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.item?.item.summary,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              widget.item?.item.prep,
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
                              '${widget.item?.item.nutrition.calories}Kal',
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
                    const Divider()
                  ],
                );
              }),
            ),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }
}
