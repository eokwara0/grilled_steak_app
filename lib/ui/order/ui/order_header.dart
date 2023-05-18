import 'package:flutter/material.dart';
import 'package:grilled_steak_app/ui/home/ui/widgets/home_header/home_header_Image.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 100,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: HeaderBackGroundImage(),

      title: const Text(
        '# Orders',
        style: TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      // pinned: true,
    );
  }
}
