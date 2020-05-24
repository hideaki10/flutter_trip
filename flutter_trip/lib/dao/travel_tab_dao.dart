import 'dart:convert';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(TRAVEL_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception("Failed to load home_page.json");
    }
  }
}
