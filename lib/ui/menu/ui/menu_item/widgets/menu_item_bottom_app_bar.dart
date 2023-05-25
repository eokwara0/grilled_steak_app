import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import 'package:grilled_steak_app/ui/widgets/snack_bar.dart';
import 'package:order_repository/order_repository.dart';

import '../../../../cart/cubit/cart_cubit.dart';

class MenuItemBottomAppBar extends StatelessWidget {
  const MenuItemBottomAppBar({
    super.key,
    required this.quantity,
    required this.price,
    required this.menuId,
  });

  final String menuId;
  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemCubit, MenuItemState>(
      builder: (menuItemContext, state) {
        return BottomAppBar(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'R${(quantity * price).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.amber[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                width: 240,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CartCubit>().addOrderItem(
                          OrderItem(
                            menuId: menuId,
                            quantity: quantity,
                            price: price,
                          ),
                        );

                    showOrderSnackBar(
                        Colors.amber[500], 'Order added to cart', context);

                    context.go('/');
                  },
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Add to Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
