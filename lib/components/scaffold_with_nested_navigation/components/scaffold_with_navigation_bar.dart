import '../components/bottom_app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
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
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/kinh');
        },
        tooltip: "Đọc kinh",
        child: const Icon(Icons.menu_book_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
              width: 40,
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
      ),
    );
  }
}
