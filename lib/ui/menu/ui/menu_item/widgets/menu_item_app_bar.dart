import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItemAppBar extends StatelessWidget {
  const MenuItemAppBar({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      stretch: true,
      expandedHeight: 380,
      collapsedHeight: 200,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          radius: 20,
          child: IconButton(
            enableFeedback: true,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey.shade700,
              size: 20,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
      ),
      flexibleSpace: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
