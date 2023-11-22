import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class KinhPage extends StatelessWidget {
  const KinhPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Tooltip(
              message: "Kinh Cúng Tứ Thời và Quan Hôn Tang Tế",
              child: Text("Kinh Cúng Tứ Thời và Quan Hôn Tang Tế"),
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Kinh Cúng Tứ Thời",
              ),
              Tab(
                text: "Quan Hôn Tang Tế",
              )
            ]),
            backgroundColor: const Color(0xFFFFFFFF),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.home),
              Icon(Icons.menu_book),
            ],
          ),
        ),
      ),
    );
  }
}
