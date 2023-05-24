import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/text_field_edit.dart';
import 'package:grilled_steak_app/ui/widgets/splash_page.dart';
import 'package:order_repository/order_repository.dart';

import '../../../app/authentication/bloc/authentication_bloc.dart';
import '../../cart/cubit/cart_cubit.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state.isCheckedOut) {
          context.go('/success?message=Order successfully placed.');
        } else if (state.isError) {
          context.go(
              '/error?message=An Error occured while creating Order, please try again');
        }
      },
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return BottomAppBar(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R${state.grandTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        if (state.orderItems.isNotEmpty) {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      width: 400,
                                      height: 350,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            child: Text(
                                              'CustomerDetails',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          EditTextField(
                                            errorText: state.username!.invalid
                                                ? 'Enter a valid name'
                                                : null,
                                            label: 'CustomerName',
                                            hint: state.username!.value,
                                            maxLines: 1,
                                            onChanged: (p0) {
                                              context
                                                  .read<CartCubit>()
                                                  .onNameChanged(p0);
                                            },
                                          ),
                                          EditTextField(
                                            errorText: state.email!.invalid
                                                ? "Enter a valid email"
                                                : null,
                                            label: 'CustomerEmail',
                                            hint: state.email!.value,
                                            maxLines: 1,
                                            onChanged: (p0) {
                                              context
                                                  .read<CartCubit>()
                                                  .onEmailChanged(p0);
                                            },
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                backgroundColor: Colors.amber,
                                              ),
                                              onPressed: () {
                                                if (state.email!.valid &&
                                                    state.username!.valid) {
                                                  context
                                                      .read<CartCubit>()
                                                      .checkOut(
                                                        context
                                                            .read<
                                                                AuthenticationBloc>()
                                                            .state
                                                            .user
                                                            .id!,
                                                      );
                                                }
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 400,
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: double.infinity,
                                        height: 40,
                                        child: IconButton(
                                          onPressed: () {
                                            context.go('/');
                                          },
                                          icon: Row(
                                            children: const [
                                              Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Icon(
                                        Icons.integration_instructions_outlined,
                                        size: 100,
                                        color: Colors.red[400],
                                      ),
                                      Text(
                                        'No Items to Checkout',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 200,
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                splashRadius: 15,
                onPressed: () {
                  context.go('/');
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey[400],
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              title: Text(
                '# Checkout',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state.isLoaded || state.isChanged) {
                          return state.menuItems.isEmpty
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      width: double.infinity,
                                      height: 40,
                                      color: Colors.grey[50],
                                      child: Text(
                                        '# Items ${state.orderItems.length} ',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ...state.menuItems
                                        .map(
                                          (e) => Column(
                                            children: [
                                              Dismissible(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                direction:
                                                    DismissDirection.endToStart,
                                                background: Container(
                                                  width: double.infinity,
                                                ),
                                                secondaryBackground: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  color: Colors.red[400],
                                                  width: double.infinity,
                                                  height: 300,
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 20.0,
                                                    ),
                                                    child: Text(
                                                      "DELETE",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                dismissThresholds: const {
                                                  DismissDirection.endToStart:
                                                      .95,
                                                },
                                                onDismissed: (direction) {
                                                  OrderItem orderItem = state
                                                      .orderItems
                                                      .firstWhere(
                                                    (el) => el.menuId == e.id,
                                                  );

                                                  context
                                                      .read<CartCubit>()
                                                      .removeItem(orderItem, e);
                                                },
                                                confirmDismiss:
                                                    (direction) async {
                                                  if (direction.index == 2) {
                                                    return true;
                                                  }
                                                  return false;
                                                },
                                                key: ValueKey(
                                                    '${e.imageUrl} ${e.item!.title}'),
                                                child: ListTile(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  title: Text(
                                                    e.item!.title!,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  subtitle:
                                                      Text(e.item!.summary!),
                                                  leading: Image.network(
                                                    e.imageUrl!,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  trailing: Container(
                                                    alignment: Alignment.center,
                                                    width: 145,
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          splashRadius: 15,
                                                          icon: Icon(
                                                            Icons.remove,
                                                            color: Colors
                                                                .grey[500],
                                                          ),
                                                          onPressed: () {
                                                            OrderItem
                                                                orderItem =
                                                                state.orderItems[
                                                                    state
                                                                        .menuItems
                                                                        .indexOf(
                                                                            e)];
                                                            OrderItem
                                                                newOrderItem =
                                                                orderItem.copyWith(
                                                                    quantity:
                                                                        orderItem.quantity -
                                                                            1);
                                                            if (orderItem
                                                                    .quantity >
                                                                1) {
                                                              context
                                                                  .read<
                                                                      CartCubit>()
                                                                  .replaceOrderItem(
                                                                    orderItem,
                                                                    newOrderItem,
                                                                  );
                                                            }
                                                          },
                                                        ),
                                                        Text(
                                                          '${state.orderItems[state.menuItems.indexOf(e)].quantity}',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          splashRadius: 15,
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.amber,
                                                          ),
                                                          onPressed: () {
                                                            OrderItem
                                                                orderItem =
                                                                state.orderItems[
                                                                    state
                                                                        .menuItems
                                                                        .indexOf(
                                                                            e)];
                                                            OrderItem
                                                                newOrderItem =
                                                                orderItem.copyWith(
                                                                    quantity:
                                                                        orderItem.quantity +
                                                                            1);
                                                            if (orderItem
                                                                    .quantity <
                                                                10) {
                                                              context
                                                                  .read<
                                                                      CartCubit>()
                                                                  .replaceOrderItem(
                                                                    orderItem,
                                                                    newOrderItem,
                                                                  );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Divider()
                                            ],
                                          ),
                                        )
                                        .toList()
                                  ],
                                );
                        }
                        return const SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: SplashPage(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
