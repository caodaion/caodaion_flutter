import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../model/kinh.dart';
import '../../service/kinh_service.dart';

class KinhDetails extends StatefulWidget {
  const KinhDetails({Key? key}) : super(key: key);

  @override
  State<KinhDetails> createState() => _KinhDetailsState();
}

class _KinhDetailsState extends State<KinhDetails> {
  late Future<List<Kinh>> kinhs;
  late Future<String> content;

  @override
  void initState() {
    super.initState();
    content = Future.value(""); // Initialize content with an empty string
    Future.delayed(Duration.zero, () {
      content = loadTextFile();
      kinhs = fetchKinhs();
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
                  builder: (context, kinhsSnapshot) {
                    if (kinhsSnapshot.hasData &&
                        kinhsSnapshot.data!.isNotEmpty) {
                      return Text(
                        kinhsSnapshot.data!
                            .firstWhere((element) => element.key == path)
                            .name,
                      );
                    } else if (kinhsSnapshot.hasError) {
                      return Text(
                          'Error loading kinhs: ${kinhsSnapshot.error}');
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
              ),
              body: Markdown(data: snapshot.data.toString()),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
