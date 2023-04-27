import 'package:flutter/material.dart';

class MenuItemBottomAppBar extends StatelessWidget {
  const MenuItemBottomAppBar({
    super.key,
    required this.quantity,
    required this.price,
  });

  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () {},
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
  }
}
