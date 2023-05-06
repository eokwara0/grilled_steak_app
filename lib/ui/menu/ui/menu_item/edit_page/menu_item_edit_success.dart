import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItemEditSuccess extends StatelessWidget {
  const MenuItemEditSuccess({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 700,
                  // color: Colors.amber,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade400,
                          size: 100,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
