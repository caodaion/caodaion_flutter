import 'package:flutter/material.dart';

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                label: Text('Trang chủ'),
                icon: Icon(Icons.home_max),
              ),
              NavigationRailDestination(
                label: Text('TNHT'),
                icon: Icon(Icons.book),
              ),
              NavigationRailDestination(
                label: Text('Đạo sự'),
                icon: Icon(Icons.newspaper),
              ),
              NavigationRailDestination(
                label: Text('Ứng dụng'),
                icon: Icon(Icons.apps),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
