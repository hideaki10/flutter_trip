import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const CITY_NAMES = [
  '北京',
  '上海',
  '广州',
  '深圳',
  '杭州',
  '苏州',
  '成都',
  '武汉',
  '郑州',
  '洛阳',
  '厦门',
  '青岛',
  '拉萨'
];

class ListViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListViewDemo();
  }
}

class _ListViewDemo extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("list"),
        ),
        body: Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildList(),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildList() {
  return CITY_NAMES.map((city) => _item(city)).toList();
}

Widget _item(city) {
  return Container(
    height: 80,
    margin: EdgeInsets.only(right: 5),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.red),
    child: Text(
      city,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}
