import 'package:billing_repository/billing_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/widgets/splash_page.dart';
import 'package:order_repository/order_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../cubit/sales_cubit.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

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
      create: (context) => SalesCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          billingRepository: RepositoryProvider.of<BillingRepository>(context),
          orderRepository: RepositoryProvider.of<OrderRepository>(context)),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            if (state.isLoaded) {
              return BottomAppBar(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Total Sales',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      state.orders.isNotEmpty
                          ? 'R ${state.orders.reduce((value, element) => element.copyWith(grandTotal: element.grandTotal + value.grandTotal)).grandTotal.toStringAsFixed(2)}'
                          : 'R ${0.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                height: 100,
                width: 100,
                child: SplashPage(),
              );
            }
          },
        ),
        appBar: AppBar(
          elevation: .5,
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.grey,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.tag,
                color: Colors.amber[400],
              ),
              const Text(
                'Sales',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ...List.generate(
                    state.bills.length,
                    (index) => Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.all(
                            5,
                          ),
                          width: 500,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                // height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '# Order${state.orders[index].id.substring(0, 6)}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.amber.withOpacity(
                                        .4,
                                      ),
                                      child: const Icon(
                                        Icons.check_circle_sharp,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'R ${state.orders[index].grandTotal.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),

                              //
                              const SizedBox(
                                height: 10,
                              ),
                              //
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        20,
                                      ),
                                      width: double.infinity,
                                      child: const Text(
                                        'Order Details',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Id',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Text(
                                                state.orders[index].id
                                                    .substring(0, 10),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Status',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.amber[400],
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    state.orders[index].status,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Time',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Text(
                                                '${days[state.orders[index].createdAt!.day % 7]} ${state.orders[index].createdAt!.day} ${months[state.orders[index].createdAt!.month]}-${state.orders[index].createdAt!.hour}:${state.orders[index].createdAt!.minute}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Customer name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Text(
                                                state.orders[index].customer
                                                    .name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order Handler',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Text(
                                                '${state.users[index].firstname![0].toUpperCase()}${state.users[index].firstname!.substring(1)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
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
                                                    (constraints.maxWidth ~/
                                                        27),
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
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Grand Total',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Text(
                                                'R ${state.orders[index].grandTotal.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
