import 'dart:convert';
import 'package:caodaion_flutter/pages/kinh_page/widgets/kinh_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
      print('Decoded Content: $decodedContent');
      setState(() {});
      return decodedContent;
    } catch (e) {
      // Handle any errors that occur during file loading or decoding
      print('Error loading text file: $e');
      return 'Error loading content';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
                      items: const [
                        DropdownMenuItem<double>(
                          value: 1.0,
                          alignment: Alignment.center,
                          child: Text("gấp 1"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.2,
                          alignment: Alignment.center,
                          child: Text("gấp 2"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.3,
                          alignment: Alignment.center,
                          child: Text("gấp 3"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.4,
                          alignment: Alignment.center,
                          child: Text("gấp 4"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.5,
                          alignment: Alignment.center,
                          child: Text("gấp 5"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.6,
                          alignment: Alignment.center,
                          child: Text("gấp 6"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.7,
                          alignment: Alignment.center,
                          child: Text("gấp 7"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.8,
                          alignment: Alignment.center,
                          child: Text("gấp 8"),
                        ),
                        DropdownMenuItem<double>(
                          value: 1.9,
                          alignment: Alignment.center,
                          child: Text("gấp 9"),
                        ),
                        DropdownMenuItem<double>(
                          value: 2,
                          alignment: Alignment.center,
                          child: Text("gấp 10"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedFontSize = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Markdown(
                      data: snapshot.data.toString(),
                      styleSheet: MarkdownStyleSheet(
                        textScaleFactor: selectedFontSize,
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
