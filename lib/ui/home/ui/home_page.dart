import 'package:flutter/material.dart';

import '../../hamburger_menu/ui/hameburger_menu_page.dart';
import 'widgets/home_body/home_page_body.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // endDrawerEnableOpenDragGesture: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_rounded,
              // size: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.receipt_long_rounded,
              // size: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.menu,
              // size: 25,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey.withOpacity(.5),
        selectedItemColor: Colors.amberAccent,
        onTap: _onTap,
        currentIndex: _currentIndex,
      ),
    );
  }
}
