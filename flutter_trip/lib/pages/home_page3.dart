import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'dart:convert';

// 滚动最大距离
const APPBAR_SCROLL_OFFSET = 100;

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() {
    // TODO: implement createState
    return _HomePage3State();
  }
}

class _HomePage3State extends State<HomePage3> {
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',
  ];

  @override
  void initState() {
    super.initState();

  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      //超过上面的边距了
      alpha = 0;
    } else if (alpha > 1) {
      //超过下面的边距了
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }


//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });
//    try {
//    HomeModel model = await HomeDao.fetch();
//    setState(() {
//      resultString = json.encode(model);
//    });
//    } catch (e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    }


  double appBarAlpha = 0;
  String resultString;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //stack 布局 前面的元素叠在后面 下面的元素会被叠在下面
      body: Stack(
        children: <Widget>[
          //移除上方的pannding 也就是手机上方的 wifi，🔋显示的一条线
          MediaQuery.removePadding(
            //指定删除哪里
            removeTop: true,
            context: context,
            //监听滚动
            child: NotificationListener<ScrollUpdateNotification>(
              // scrollNotification.depth == 0 listview滚动的时候
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  //滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  //banner
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      //三点
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text("haha"),
                    ),
                  )
                ],
              ),
            ),
          ),
          //
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("gigigi"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
