import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grilled_steak_app/ui/order/cubit/order_cubit.dart';
import 'package:grilled_steak_app/ui/order/ui/order_bill/cubit/order_bill_cubit.dart';
import 'package:grilled_steak_app/ui/widgets/button_widget.dart';
import 'package:grilled_steak_app/ui/widgets/splash_page.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../widgets/snack_bar.dart';
import 'order_bill/order_bill.dart';
import 'order_header.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

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
      create: (context) => OrderCubit(
        menuItemRepo: RepositoryProvider.of<MenuItemRepository>(context),
        orderRepo: RepositoryProvider.of<OrderRepository>(context),
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state.isOrdered) {
            showSnackBar(
              Colors.amber[500],
              'Order has been placed',
              context,
            );
          } else if (state.isError) {
            showSnackBar(
              Colors.red[400],
              'An error occurred',
              context,
            );
          } else if (state.isClosed) {
            showSnackBar(
              Colors.amber[500],
              'Order was closed Successfully',
              context,
            );
          }
        },
        child: BlocBuilder<OrderCubit, OrderState>(
          buildWhen: (previous, current) {
            return true;
          },
          builder: (_, state) {
            OrderCubit cubit = _.read<OrderCubit>();

            if (state.isLoaded) {
              return CustomScrollView(
                slivers: [
                  const OrderHeader(),
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
                              List<MenuItem> items =
                                  state.menuOrderItems[index];

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
                                          padding: const EdgeInsets.all(8.0),
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
                                                  Icons
                                                      .breakfast_dining_outlined,
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
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${days[order.createdAt!.day % 7]} ${order.createdAt!.day} ${months[order.createdAt!.month]}-${order.createdAt!.hour}:${order.createdAt!.minute}',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
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
                                                        color: Colors.amber,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          5,
                                                        ),
                                                        color: order.status
                                                                    .toLowerCase() ==
                                                                'canceled'
                                                            ? Colors.amber[500]
                                                            : order.status
                                                                        .toLowerCase() ==
                                                                    'ready'
                                                                ? Colors
                                                                    .green[400]
                                                                : Colors
                                                                    .grey[400],
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                        order.status
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[50],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width +
                                                            100,
                                                    height: 100,
                                                    child: Row(
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
                                                              image:
                                                                  NetworkImage(
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
                                                          width: 170,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                items[ind]
                                                                    .item!
                                                                    .title!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
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
                                                          mainAxisSize:
                                                              MainAxisSize.max,
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
                                            GrilledHouseButton(
                                              content: 'Order Again',
                                              color: Colors.black87,
                                              onPressed: () {
                                                BlocProvider.of<OrderCubit>(_)
                                                    .orderAgain(order);
                                              },
                                            ),
                                            if (order.status.toLowerCase() ==
                                                'canceled')
                                              GrilledHouseButton(
                                                content: 'Close Order',
                                                color: Colors.red[400],
                                                onPressed: () {
                                                  BlocProvider.of<OrderCubit>(_)
                                                      .closeOrder(order);
                                                },
                                              ),
                                            if (order.status.toLowerCase() ==
                                                'ready')
                                              GrilledHouseButton(
                                                content: 'Generate Bill',
                                                color: Colors.amber[600],
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return BlocProvider(
                                                        create: (_) =>
                                                            OrderBillCubit(
                                                                orderCubit:
                                                                    cubit,
                                                                orderState:
                                                                    state),
                                                        child: OrderBill(
                                                          order: order,
                                                          days: days,
                                                          months: months,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
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
            } else {
              return const SizedBox.expand(
                child: SplashPage(),
              );
            }
          },
        ),
      ),
    );
  }
}
