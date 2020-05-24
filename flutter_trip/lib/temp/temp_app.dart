import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:http/http.dart' as http;

class tempApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tempAppState();
  }
}

class _tempAppState extends State<tempApp> {
  String showResult = "";

  Future<CommonModel> fetchPost() async {
    final response = await http
        .get("http://www.devio.org/io/flutter_app/json/test_common_model.json");
    Utf8Decoder utf8decoder = Utf8Decoder();
    final result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http"),
        ),
        // weidget →　FutureBuilder
        body: FutureBuilder<CommonModel>(
          future: fetchPost(),

          builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("input a url to start");
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return Text("");
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Text('icon:${snapshot.data.icon}'),
                      Text('statusBarColor:${snapshot.data.statusBarColor}'),
                      Text('title:${snapshot.data.title}'),
                      Text('url:${snapshot.data.url}')
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
