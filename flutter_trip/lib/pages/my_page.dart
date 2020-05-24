import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/web_view.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    // TODO: implement createState
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: "448AFF",
      ),
    );
  }
}