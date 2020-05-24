import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:http/http.dart' as http;

var params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": 1,
  "lat": 35.7236736,
  "lon": 139.69981439999998,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031172111006652645"},
  "contentType": "json"
};

//class TravelDao {
//  static Future<TravelItemModel> fetch(
//      String url, String groupChannelCode, int pageIndex, int pageSize) async {
//    Map paramMap = params['pagePara'];
//    paramMap["pageIndex"] = pageIndex;
//    paramMap["pageSize"] = pageSize;
//    params["groupChannelCode"] = groupChannelCode;
//
//    final response = await http.post(url, body: jsonEncode(params));
//
//    if (response.statusCode == 200) {
//      Utf8Decoder utf8decoder = Utf8Decoder();
//      var result = json.decode(utf8decoder.convert(response.bodyBytes));
//      return TravelItemModel.fromJson(result);
//    } else {
//      throw Exception("failed to load travel_page");
//    }
//  }
//}

class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    params['groupChannelCode'] = groupChannelCode;
    final response = await http.post(url, body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}