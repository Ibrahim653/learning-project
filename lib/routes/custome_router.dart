import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_files/screens/clock/clock.dart';
import 'package:riverpod_files/screens/counter/counter_page.dart';
import 'package:riverpod_files/screens/home/home_screen.dart';
import 'package:riverpod_files/screens/products/products_list_screen.dart';
import 'package:riverpod_files/screens/widgets/page_not_found_screen.dart';

import '../screens/home/scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';

// private navigators
// we use two navigators to separate the shell from the root navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  home('/home'),
  counter('/counter'),
  cart('/cart'),
  clock('/clock'),
  productList('/productList');

  final String path;

  const AppRoute(this.path);
}

class CustomRouter {
  CustomRouter._();

  static final provider = Provider<CustomRouter>((ref) {
    return CustomRouter._();
  });

  final goRouter = GoRouter(
    initialLocation: AppRoute.home.path,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return null;
    },
    routes: [
      //StatefulShellRoute is a wrapper for the navigation shell widget
      //it is used to manage the state of the navigation shell
      //you can use it in the root navigator or in any nested navigator
      //the nasted page saved in the state of the navigation shell
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => MaterialPage(
          child: ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
          ),
        ),
        branches: <StatefulShellBranch>[
          // the first branch is the home branch in bottom navigation bar
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          // the second branch is the counter branch in bottom navigation bar
          // it has a nested branch for the counter details screen
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.counter.path,
                name: AppRoute.counter.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: CounterPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.clock.path,
                name: AppRoute.clock.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: Clock()),
              ),
            ],
          ),
           StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.productList.path,
                name: AppRoute.productList.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProductListScreen()),
              ),
            ],
          ),
        
        ],
      ),
    ],
    errorBuilder: (_, state) => const PageNotFoundScreen(),
  );
}
