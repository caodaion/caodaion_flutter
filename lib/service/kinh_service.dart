import 'dart:convert';
import 'package:caodaion_flutter/model/kinh.dart';
import 'package:flutter/services.dart';

Future<List<Kinh>> fetchKinhs() async {
  String jsonString =
      await rootBundle.loadString('assets/content/kinh/kinh_list.json');
  List<dynamic> data = json.decode(jsonString);
  return data.map((json) => Kinh.fromJson(json)).toList();
}
