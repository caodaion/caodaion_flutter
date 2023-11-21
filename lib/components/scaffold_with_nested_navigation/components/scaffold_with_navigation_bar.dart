import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          destinations: const [
            NavigationDestination(
              label: 'Trang chủ',
              icon: Icon(Icons.home_max),
              tooltip: "Trang chủ",
            ),
            NavigationDestination(
              label: 'TNHT',
              icon: Icon(Icons.book),
              tooltip: "Thánh Ngôn Hiệp Tuyển",
            ),
            NavigationDestination(
              label: 'Đạo sự',
              icon: Icon(Icons.newspaper),
              tooltip: "Đạo sự",
            ),
            NavigationDestination(
              label: 'Ứng dụng',
              icon: Icon(Icons.apps),
              tooltip: "Ứng dụng",
            ),
          ],
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}
