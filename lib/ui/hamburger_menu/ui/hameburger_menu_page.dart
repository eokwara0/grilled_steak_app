import 'package:flutter/material.dart';

class HamBurgerMenuPage extends StatefulWidget {
  const HamBurgerMenuPage({super.key});

  @override
  State<HamBurgerMenuPage> createState() => _HamBurgerMenuPageState();
}

class _HamBurgerMenuPageState extends State<HamBurgerMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 22,
              ),
              title: Text(
                'View Profile',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.lock_reset,
                size: 22,
              ),
              title: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 22,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
