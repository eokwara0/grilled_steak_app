import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HamBurgerMenuPage extends StatefulWidget {
  const HamBurgerMenuPage({super.key});

  @override
  State<HamBurgerMenuPage> createState() => _HamBurgerMenuPageState();
}

class _HamBurgerMenuPageState extends State<HamBurgerMenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (p0, p1) {
          return Material(
            color: Colors.white30,
            child: ListView(
              padding: EdgeInsets.all(5),
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  widthFactor: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomLeft,
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text('Hi how are we doing'),
                    subtitle: Text('orders'),
                    leading: Icon(Icons.shopping_cart_checkout),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
