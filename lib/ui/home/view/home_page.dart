import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grilled_steak_app/ui/hamburger_menu/ui/hameburger_menu_page.dart';
import 'package:grilled_steak_app/ui/home/view/widgets/home_page_body.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../authentication/bloc/authentication_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [
      const HomePageBody(),
      Container(),
      const HamBurgerMenuPage(),
    ];
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              tooltip: 'orders',
              label: 'orders',
              icon: Icon(
                Icons.shopping_bag,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              tooltip: 'menu',
              label: 'menu',
              icon: Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          // showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.withOpacity(.5),
          selectedItemColor:
              Theme.of(context).colorScheme.primary.withOpacity(.9),
          onTap: _onTap,
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
