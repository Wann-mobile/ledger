import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger/src/root_presentaion/utils/navigation_utils.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  final selectedIndex = 0;
  void _onTap(int index) {
    NavigationUtils.indexNavigation(index, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: NavigationUtils.scaffoldKey,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onTap(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Statements',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
