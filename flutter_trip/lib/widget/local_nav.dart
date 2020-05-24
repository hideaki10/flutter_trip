import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/web_view.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;


  const LocalNav({Key key, @required this.localNavList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: _items(context)
        ,
      )
      ,
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) {
      return null;
    }
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    //生成1列
    return Row(
      // 水平排列
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebView(url: commonModel.url,
              statusBarColor: commonModel.statusBarColor,
              hideAppBar: commonModel.hideAppBar,
            )
          )
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(
            commonModel.icon,
            width: 32,
            height: 32,
          ),
          Text(
            commonModel.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
