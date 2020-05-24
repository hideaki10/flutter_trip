import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/web_view.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];

    if (gridNavModel == null) return items;

    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem item, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, item.mainItem));
    items.add(_doubleItem(context, item.item1, item.item2));
    items.add(_doubleItem(context, item.item3, item.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    Color startColor = Color(int.parse("0xff" + item.startColor));
    Color endColor = Color(int.parse("0xff" + item.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //设置整个一行线性渐变色
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              commonModel.icon, fit: BoxFit.contain, height: 88, width: 121,
              //图片在框的底下

              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              // 设置顶部间距
              margin: EdgeInsets.only(top: 11),
              child: Text(
                commonModel.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        commonModel);
  }

  _doubleItem(
      BuildContext context, CommonModel commonModel, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, commonModel, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            // 左边划线
            left: borderSide,
            // 底部划线 如果是第一个就划线 不是就none
            bottom: first ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: commonModel.url,
                      statusBarColor: commonModel.statusBarColor,
                      hideAppBar: commonModel.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
