import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class ExpansionTitleDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpansionTitleDemo();
  }
}

class _ExpansionTitleDemo extends State<ExpansionTitleDemo> {
  final title = "shuiping";
  final titleSecond = "sss";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(titleSecond),
        ),
        body: Container(
          child: ListView(
            children: _buildList(),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildList() {
  List<Widget> widgets = [];
  CITY_NAMES.keys.forEach((key) {
    widgets.add(_item(key, CITY_NAMES[key]));
  });
  return widgets;
}

Widget _item(String key, List<String> cityNames) {
  return ExpansionTile(
    title: Text(
      key,
      style: TextStyle(color: Colors.blue, fontSize: 20),
    ),
    children: cityNames.map((cityNames) => _buildSub(cityNames)).toList(),
    trailing: IconButton(
        icon: Icon(
      Icons.add,
    )),
  );
}

Widget _buildSub(String cityNames) {
  return FractionallySizedBox(
    widthFactor: 1,
    child: Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.amberAccent),
      child: Text(cityNames),
    ),
  );
}
