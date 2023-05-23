import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';

import '../cubit/chef_home_page_cubit.dart';

class ChefHomePage extends StatelessWidget {
  const ChefHomePage({super.key});

  final List<String> days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  final List<String> months = const [
    'January',
    'February',
    'March',
    "April",
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefHomePageCubit(
        menuItemRepo: RepositoryProvider.of<MenuItemRepository>(context),
        orderRepo: RepositoryProvider.of<OrderRepository>(context),
      ),
      child: BlocListener<ChefHomePageCubit, ChefHomePageState>(
        listener: (context, state) {
          if (state.isReady) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 1,
                dismissDirection: DismissDirection.endToStart,
                backgroundColor: Colors.amber[500],
                behavior: SnackBarBehavior.floating,
                width: 400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                showCloseIcon: true,
                closeIconColor: Colors.white,
                content: SizedBox(
                  height: 25,
                  child: Row(
                    children: const [
                      Text(
                        'Order is now ready',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.isCancel) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 1,
                dismissDirection: DismissDirection.endToStart,
                backgroundColor: Colors.amber[500],
                behavior: SnackBarBehavior.floating,
                width: 400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                showCloseIcon: true,
                closeIconColor: Colors.white,
                content: SizedBox(
                  height: 25,
                  child: Row(
                    children: const [
                      Text(
                        'Order has been canceled',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 1,
                dismissDirection: DismissDirection.endToStart,
                backgroundColor: Colors.red[400],
                behavior: SnackBarBehavior.floating,
                width: 400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                showCloseIcon: true,
                closeIconColor: Colors.white,
                content: SizedBox(
                  height: 25,
                  child: Row(
                    children: const [
                      Text(
                        'An error occurred',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<ChefHomePageCubit, ChefHomePageState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  toolbarHeight: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, 100),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        enabled: true,
                        autocorrect: false,

                        // cursor color
                        cursorColor: Colors.amber,

                        // search decoration
                        decoration: InputDecoration(
                          //prefix icon
                          suffixIconColor: Colors.grey,
                          suffixIcon: const Icon(
                            Icons.search,
                            size: 30,
                          ),

                          // filled
                          filled: true,

                          // fill color
                          fillColor: Colors.grey.shade200.withOpacity(.8),
                          // content padding

                          contentPadding: const EdgeInsets.all(10),

                          // default border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),

                          // focused border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),

                        // onSubmitted
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  // pinned: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          '# Orders ${state.orders.length}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...List.generate(
                          state.orders.length,
                          (index) {
                            Order order = state.orders[index];
                            List<MenuItem> items = state.menuOrderItems[index];

                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[200],
                                              ),
                                              child: const Icon(
                                                Icons.breakfast_dining_outlined,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            // order and data
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Order #${order.id.substring(0, 5)}',
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '${days[order.createdAt!.day % 7]} ${order.createdAt!.day} ${months[order.createdAt!.month]}-${order.createdAt!.hour}:${order.createdAt!.minute}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              // color: Colors.amber,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    order.type,
                                                    style: const TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    order.status.toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ...List.generate(
                                                (constraints.maxWidth ~/ 28),
                                                (index) => Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 6,
                                                      height: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      ExpansionTile(
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide.none,
                                        ),
                                        childrenPadding:
                                            const EdgeInsets.all(10),
                                        leading: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 70,
                                          width: 200,
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${order.items.length} ${order.items.length > 1 ? 'items' : 'item'}')
                                            ],
                                          ),
                                        ),
                                        title: const Text(''),
                                        trailing: Text(
                                          'R${order.grandTotal.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        children: [
                                          ...List.generate(
                                            items.length,
                                            (ind) => Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  height: 100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            100,
                                                          ),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              items[ind]
                                                                  .imageUrl!,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              items[ind]
                                                                  .item!
                                                                  .title!,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              items[ind]
                                                                  .item!
                                                                  .title!,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .grey[500],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '#Items ${order.items[ind].quantity}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .grey[700],
                                                            ),
                                                          ),
                                                          Text(
                                                            'R${((order.items[ind].price) * (order.items[ind].quantity)).toStringAsFixed(2)}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[500],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: FilledButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ChefHomePageCubit>(
                                                        context)
                                                    .readyOrder(order);
                                              },
                                              style: FilledButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor:
                                                    Colors.amber[600],
                                              ),
                                              child: const Text('Ready'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: FilledButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ChefHomePageCubit>(
                                                        context)
                                                    .cancelOrder(order);
                                              },
                                              style: FilledButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor:
                                                    Colors.red[500],
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
