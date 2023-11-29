import 'dart:convert';
import 'package:caodaion_flutter/pages/kinh_page/widgets/kinh_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import '../../model/kinh.dart';
import '../../service/kinh_service.dart';
import 'package:go_router/go_router.dart';

class KinhDetails extends StatefulWidget {
  const KinhDetails({Key? key})
      : super(
          key: key,
        );

  @override
  State<KinhDetails> createState() => _KinhDetailsState();
}

class _KinhDetailsState extends State<KinhDetails> {
  late Future<List<Kinh>> kinhs;
  late Future<String> content;
  double selectedFontSize = 1.0;

  @override
  void initState() {
    super.initState();
    content = Future.value(""); // Initialize content with an empty string
    Future.delayed(Duration.zero, () {
      content = loadTextFile();
      Future.delayed(Duration.zero, () {
        kinhs = fetchKinhs();
      });
    });
  }

  Future<String> loadTextFile() async {
    try {
      final settings = ModalRoute.of(context)!.settings;
      final Map<String, dynamic> args =
          settings.arguments as Map<String, dynamic>;
      final path = args['path'];

      // Load content as a list of bytes
      final bytes = await rootBundle.load('assets/content/kinh/$path.txt');

      // Decode content using UTF-8
      String decodedContent = utf8.decode(bytes.buffer.asUint8List());
      setState(() {});
      return decodedContent;
    } catch (e) {
      // Handle any errors that occur during file loading or decoding
      return 'Error loading content';
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ModalRoute.of(context)!.settings;
    final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
    final path = args['path'];
    return SafeArea(
      child: FutureBuilder(
        future: content,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                // Use the title of the first item in the kinhs list
                title: FutureBuilder(
                  future: kinhs,
                  builder: (context, kinhListSnapshot) {
                    if (kinhListSnapshot.hasData &&
                        kinhListSnapshot.data!.isNotEmpty) {
                      return Text(
                        kinhListSnapshot.data!
                            .firstWhere((element) => element.key == path)
                            .name,
                      );
                    } else if (kinhListSnapshot.hasError) {
                      return Text(
                          'Error loading kinhs: ${kinhListSnapshot.error}');
                    } else {
                      return const Text('Loading...');
                    }
                  },
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.go('/kinh');
                  },
                ),
              ),
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<double>(
                      value: selectedFontSize,
                      items: [
                        1.0,
                        1.1,
                        1.2,
                        1.3,
                        1.4,
                        1.5,
                        1.6,
                        1.7,
                        1.8,
                        1.9,
                        2.0
                      ].map((fontSize) {
                        return DropdownMenuItem<double>(
                          value: fontSize,
                          child: Text(
                            "Kích thước chữ x${fontSize.toString()}",
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFontSize = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SelectionArea(
                        child: SingleChildScrollView(
                          child: MarkdownBody(
                            data: snapshot.data.toString(),
                            styleSheet: MarkdownStyleSheet(
                              textScaleFactor: selectedFontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: kinhs,
                    builder: (context, kinhListSnapshot) {
                      if (kinhListSnapshot.hasData &&
                          kinhListSnapshot.data!.isNotEmpty) {
                        int mainIndex = kinhListSnapshot.data!
                            .indexWhere((element) => element.key == path);
                        List kinhList = kinhListSnapshot.data!
                            .where((element) =>
                                element.group ==
                                kinhListSnapshot.data![mainIndex].group)
                            .toList();
                        int index = kinhList
                            .indexWhere((element) => element.key == path);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KinhNavigationButton(
                              buttonText:
                                  kinhList[index - 1 < 0 ? 0 : index - 1]
                                          .name ??
                                      '',
                              onPressed: () {
                                context.go(
                                    '/kinh/${kinhList[index - 1 < 0 ? 0 : index - 1].key}');
                                context.push(
                                    '/kinh/${kinhList[index - 1 < 0 ? 0 : index - 1].key}');
                              },
                              icon: Icons.arrow_back,
                              iconLocation: "start",
                            ),
                            KinhNavigationButton(
                              buttonText: kinhList[index + 1 == kinhList.length
                                          ? index
                                          : index + 1]
                                      .name ??
                                  '',
                              onPressed: () {
                                context.go(
                                    '/kinh/${kinhList[index + 1 == kinhList.length ? index : index + 1].key}');
                                context.push(
                                    '/kinh/${kinhList[index + 1 == kinhList.length ? index : index + 1].key}');
                              },
                              icon: Icons.arrow_forward,
                              iconLocation: "end",
                            ),
                          ],
                        );
                      } else if (kinhListSnapshot.hasError) {
                        return Text(
                            'Error loading kinhs: ${kinhListSnapshot.error}');
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
