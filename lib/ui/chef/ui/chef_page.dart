import 'package:flutter/material.dart';
import 'package:grilled_steak_app/ui/chef/ui/chef_home_page/ui/chef_home_page.dart';
import 'package:grilled_steak_app/ui/hamburger_menu/ui/hameburger_menu_page.dart';

class ChefPage extends StatefulWidget {
  const ChefPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const ChefPage(),
    );
  }

  @override
  State<ChefPage> createState() => _ChefPageState();
}

class _ChefPageState extends State<ChefPage> {
  late int _currentIndex;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [
      const ChefHomePage(),
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.list_alt_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.menu,
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
