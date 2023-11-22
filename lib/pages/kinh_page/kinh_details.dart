import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import '../../../service/kinh_service.dart';

class KinhDetails extends StatefulWidget {
  const KinhDetails({super.key});

  @override
  State<KinhDetails> createState() => _KinhDetailsState();
}

class _KinhDetailsState extends State<KinhDetails> {
  @override
  Widget build(BuildContext context) {
    final settings = ModalRoute.of(context)!.settings;
    final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
    final key = args['key'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(key),
        ),
        body: Markdown(data: "fileContent"),
      ),
    );
  }
}
