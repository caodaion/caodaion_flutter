import 'dart:convert';
import 'package:caodaion_flutter/model/kinh.dart';
import 'package:flutter/services.dart';

Future<String> loadJsonData() async {
  return await rootBundle.loadString('assets/content/kinh/kinh_list.json');
}

List<Kinh> parseJson(String response) {
  final parsed = json.decode(response).cast<Map<String, dynamic>>();
  return parsed.map<Kinh>((json) => Kinh.fromJson(json)).toList();
}
