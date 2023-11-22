import './widgets/kinh_list.dart';
import 'package:flutter/material.dart';

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
              KinhList(
                listType: 'cung_tu_thoi',
              ),
              KinhList(
                listType: 'quan_hon_tang_te',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
