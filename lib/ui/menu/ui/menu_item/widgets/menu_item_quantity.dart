import 'package:flutter/material.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuItemQuantity extends StatelessWidget {
  const MenuItemQuantity({
    super.key,
    required this.menuItem,
    required this.quantity,
    required this.callback,
  });
  final MenuItem menuItem;
  final int quantity;
  final ValueChanged<int> callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          // item price sections start
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'R${menuItem.item?.price}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'R${(menuItem.item!.price! + 4.99).round()}.99',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          decoration: TextDecoration.combine(
                            [
                              TextDecoration.lineThrough,
                              TextDecoration.overline
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),

          // price end
          const Padding(
            padding: EdgeInsets.only(right: 60),
          ),

          // quantity Icons start
          Container(
            width: 130,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  splashRadius: 1,
                  enableFeedback: true,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.remove_circle,
                    size: 35,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    if (quantity > 1) callback(quantity - 1);
                  },
                ),
                Text('${quantity.abs()}'),
                IconButton(
                  enableFeedback: true,
                  visualDensity: VisualDensity.compact,
                  splashRadius: 1,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.add_circle_outlined,
                    size: 35,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    callback(quantity + 1);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
