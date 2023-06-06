import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/detail_model.dart';

class GetJson {
  static Future<DetailModel> getData(String type) async {
    final response = await rootBundle.loadString('text/info.json');
    final data = json.decode(response);
    return DetailModel.fromJson(data, type);
  }
}
