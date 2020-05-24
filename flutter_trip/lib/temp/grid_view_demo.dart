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

class GridViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GridViewDemo();
  }
}

class _GridViewDemo extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "sdad",
      home: Scaffold(
        appBar: AppBar(
          title: Text("dsds", style: TextStyle(fontSize: 20)),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: _buildList(),
        ),
      ),
    );
  }
}

List<Widget> _buildList() {
  return CITY_NAMES.map((city) => _item(city)).toList();
}

//List<Widget> _buildList() {
//  return CITY_NAMES.map((city) => _item(city)).toList();
//}
Widget _item(String city) {
  return Container(
    height: 80,
    margin: EdgeInsets.only(bottom: 5),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
    child: Text(
      city,
      style: TextStyle(color: Colors.blue, fontSize: 20),
    ),
  );
}
