import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/bottom_app_bar_item.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/kinh');
        },
        tooltip: "Đọc kinh",
        child: const Icon(Icons.menu_book_rounded),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      body: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              BottomAppBarItem(
                onPressed: () {
                  context.go('/');
                },
                label: "Trang chủ",
                iconData: Icons.home_max,
                route: '/',
                isActive: selectedIndex == 0,
                tooltip: "Trang chủ",
              ),
              const SizedBox(
                height: 12,
              ),
              BottomAppBarItem(
                onPressed: () {
                  context.go('/tnht');
                },
                label: "TNHT",
                iconData: Icons.book_rounded,
                route: '/tnht',
                isActive: selectedIndex == 1,
                tooltip: "Thánh Ngôn Hiệp Tuyển",
              ),
              const SizedBox(
                height: 12,
              ),
              BottomAppBarItem(
                onPressed: () {
                  context.go('/dao-su');
                },
                label: "Đạo sự",
                iconData: Icons.newspaper,
                route: '/dao-su',
                isActive: selectedIndex == 2,
                tooltip: "Đạo sự",
              ),
              const SizedBox(
                height: 12,
              ),
              BottomAppBarItem(
                onPressed: () {
                  context.go('/ung-dung');
                },
                label: "Ứng dụng",
                iconData: Icons.apps,
                route: '/ung-dung',
                isActive: selectedIndex == 3,
                tooltip: "Ứng dụng",
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
