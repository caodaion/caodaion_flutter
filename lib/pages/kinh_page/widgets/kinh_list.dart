import 'package:flutter/material.dart';
import '../../../model/kinh.dart';
import '../../../constant/constant.dart';
import '../../../service/kinh_service.dart';

class KinhList extends StatefulWidget {
  const KinhList({super.key, required this.listType});
  final String listType;

  @override
  State<KinhList> createState() => _KinhListState();
}

class _KinhListState extends State<KinhList> {
  late List<Kinh> kinhs;

  @override
  void initState() {
    super.initState();
    loadJsonData().then((String jsonString) {
      setState(() {
        kinhs = parseJson(jsonString);
        if (widget.listType.isNotEmpty) {
          kinhs = parseJson(jsonString)
              .where((element) => element.group == widget.listType)
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GridView.builder(
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
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: kinhs.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Card(
          child: TextButton(
            onPressed: () {},
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
              kinhs[index].name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
