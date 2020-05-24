import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> cityNames = [
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

class RefreshDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RefreshDemo();
  }
}

class _RefreshDemo extends State<RefreshDemo> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      //事件监听 滚动的位置到达最大 也就是底部 触发 loaddata
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "da",
      home: Scaffold(
        appBar: AppBar(
          title: Text("da"),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            controller: _scrollController,
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.amber),
      child: Text(
        city,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  void _loadData() async {
    //延时2秒
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      //复制数组
      List<String> list = List<String>.from(cityNames);
      //加入数组 有2份数组
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}
