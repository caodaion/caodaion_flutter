// private navigators
import 'package:caodaion_flutter/pages/apps_page/apps_page.dart';
import 'package:caodaion_flutter/pages/dao_su_page/dao_su_page.dart';
import 'package:caodaion_flutter/pages/home_page/home_page.dart';
import 'package:caodaion_flutter/pages/kinh_page/kinh_page.dart';
import 'package:caodaion_flutter/pages/tnht_page/tnht_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/scaffold_with_nested_navigation/scaffold_with_nested_navigation.dart';
import '../pages/details_screen/details_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorTNHTKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellTNHT');
final _shellNavigatorDaoSuKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellDaoSu');
final _shellNavigatorAppsKey =
    GlobalKey<NavigatorState>(debugLabel: '_shellApps');
final _shellNavigatorKinhKey =
    GlobalKey<NavigatorState>(debugLabel: '_shellKinh');

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorTNHTKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/tnht',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TNHTPage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDaoSuKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/dao-su',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DaoSuPage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAppsKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/ung-dung',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AppsPage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKinhKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/kinh',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: KinhPage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
