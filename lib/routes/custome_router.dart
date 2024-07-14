import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_files/screens/cart/cart_screen.dart';
import 'package:riverpod_files/screens/clock/clock.dart';
import 'package:riverpod_files/screens/counter/counter_page.dart';
import 'package:riverpod_files/screens/home/home_screen.dart';
import 'package:riverpod_files/screens/products/products_list_screen.dart';
import 'package:riverpod_files/screens/widgets/page_not_found_screen.dart';

import '../screens/home/scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';
import '../screens/login/login_screen.dart';
import '../screens/products/product_details_screen.dart';

// private navigators
// we use two navigators to separate the shell from the root navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  login('/login'),
  home('/home'),
  counter('/counter'),
  cart('/cart'),
  clock('/clock'),
  productList('/productList'),
  productDetails('/productDetails');

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
//login page

      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),

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
                    const NoTransitionPage(child: ClockScreen()),
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
      GoRoute(
        path: AppRoute.cart.path,
        name: AppRoute.cart.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CartScreen()),
      ),
      GoRoute(
        path: AppRoute.productDetails.path,
        name: AppRoute.productDetails.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: ProductDetailsScreen());
        },
      ),
    ],
    errorBuilder: (_, state) => const PageNotFoundScreen(),
  );
}
