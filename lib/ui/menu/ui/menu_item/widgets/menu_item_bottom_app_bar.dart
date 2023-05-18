import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/cart/cubit/cart_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/cubit/menu_item_cubit.dart';
import 'package:order_repository/order_repository.dart';

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
      builder: (context, state) {
        return BottomAppBar(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: OutlinedButton(
            onPressed: () {
              context.read<CartCubit>().addOrderItem(
                    OrderItem(
                      menuId: menuId,
                      quantity: quantity,
                      price: price,
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 1,
                  dismissDirection: DismissDirection.endToStart,
                  backgroundColor: Colors.amber[600],
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
                      children: [
                        const Text(
                          'Order added to cart',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('checkout'),
                        )
                      ],
                    ),
                  ),
                ),
              );

              context.go('/');
            },
            style: OutlinedButton.styleFrom(
              splashFactory: InkSplash.splashFactory,
              enableFeedback: true,
              backgroundColor: Colors.amber,
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Add to Order R${(quantity * price).toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
