import 'package:flutter/material.dart';

class NavBarItem extends BottomNavigationBarItem {
  const NavBarItem({
    required this.initialLocation,
    required super.icon,
    super.label,
  });

  /// The initial location/path
  final String initialLocation;
}
