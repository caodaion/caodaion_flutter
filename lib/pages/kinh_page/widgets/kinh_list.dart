import 'package:flutter/material.dart';
import '../../../model/kinh.dart';
import '../../../constant/constant.dart';
import '../../../service/kinh_service.dart';
import 'package:go_router/go_router.dart';

class KinhList extends StatefulWidget {
  const KinhList({super.key, required this.listType});
  final String listType;

  @override
  State<KinhList> createState() => _KinhListState();
}

class _KinhListState extends State<KinhList> {
  late Future<List<Kinh>> kinhs;

  @override
  void initState() {
    super.initState();
    kinhs = fetchKinhs();
    if (widget.listType.isNotEmpty) {
      kinhs = kinhs;
    }
  }

  List<Kinh> filterItems(List<Kinh> items) {
    return items.where((item) => item.group == widget.listType).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<List<Kinh>>(
        future: kinhs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Kinh> filteredItems = filterItems(snapshot.data!);
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenSize.width < portraitPhones
                    ? 2
                    : screenSize.width < tablets
                        ? 3
                        : screenSize.width < laptops
                            ? 4
                            : screenSize.width < largeDevices
                                ? 5
                                : 6,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: TextButton(
                    onPressed: () {
                      context.go('/kinh/${filteredItems[index].key}');
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFE0E0E0),
                      ),
                      backgroundColor: const Color(0xFFFFFFFF),
                    ),
                    child: Text(
                      filteredItems[index].name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: screenSize.width < largeDevices ? 12 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
