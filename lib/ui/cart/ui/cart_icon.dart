import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/cart_cubit.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        return previous.length != current.length;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 30),
          child: IconButton(
            splashRadius: 20,
            icon: Badge(
              smallSize: 30,
              largeSize: 20,
              backgroundColor: Colors.amber,
              label: Text(
                '${state.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 25,
              ),
            ),
            onPressed: () {
              context.go('/checkout');
            },
          ),
        );
      },
    );
  }
}
