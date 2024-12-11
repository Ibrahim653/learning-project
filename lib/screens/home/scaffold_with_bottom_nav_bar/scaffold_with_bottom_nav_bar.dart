import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routes/custome_router.dart';
import '../../widgets/nav_bar_item.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  // the navigation shell that will be used as the body of the scaffold
  // and will be used to navigate between the tabs
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNavBar({super.key, required this.navigationShell});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // the current index of the selected tab
  int get _currentIndex => widget.navigationShell.currentIndex;

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // navigate to the desired tab using the navigation shell
      widget.navigationShell.goBranch(tabIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          NavBarItem(
            initialLocation: AppRoute.home.path,
            icon: const Icon(Icons.home),
            label: LocaleKeys.home_screen_title.tr(),
          ),
          NavBarItem(
            initialLocation: AppRoute.counter.path,
            icon: const Icon(Icons.add),
            label: 'Counter',
          ),
          NavBarItem(
            initialLocation: AppRoute.clock.path,
            icon: const Icon(Icons.lock_clock),
            label: "Clock",
          ),
              NavBarItem(
            initialLocation: AppRoute.productList.path,
            icon: const Icon(Icons.shopping_cart_outlined),
            label: "Products",
          ),
       
        ],
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(context, index),
               type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
