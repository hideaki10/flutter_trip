import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() {
    // TODO: implement createState
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {
  // 選択されてない場合、アイコンの色は灰
  final _defaultColor = Colors.grey;

  // 選択されている場合、アイコンの色は青
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  // 初回オープン際に、表示させたベージ
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        // scroll
        physics: NeverScrollableScrollPhysics(),
        // コントローラー
        controller: _controller,
        // 表示させるページ
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        // 将底部的icon固定 而不是选择的时候变大
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomNavigationBarItem("homepage", _currentIndex, 0),
          _bottomNavigationBarItem("searchpage", _currentIndex, 1),
          _bottomNavigationBarItem("travelpage", _currentIndex, 2),
          _bottomNavigationBarItem("mypage", _currentIndex, 3),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.home,
//                color: _defaultColor,
//              ),
//              activeIcon: Icon(
//                Icons.home,
//                color: _activeColor,
//              ),
//              title: Text(
//                "homepage",
//                style: TextStyle(
//                  // 1の場合、選択された、1ではない場合、選択されてない
//                  color: _currentIndex != 0 ? _defaultColor : _activeColor,
//                ),
//              )),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.search,
//                color: _defaultColor,
//              ),
//              activeIcon: Icon(
//                Icons.search,
//                color: _activeColor,
//              ),
//              title: Text(
//                "searchpage",
//                style: TextStyle(
//                  // 1の場合、選択された、1ではない場合、選択されてない
//                  color: _currentIndex != 1 ? _defaultColor : _activeColor,
//                ),
//              )),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.camera_alt,
//                color: _defaultColor,
//              ),
//              activeIcon: Icon(
//                Icons.camera_alt,
//                color: _activeColor,
//              ),
//              title: Text(
//                "travelpage",
//                style: TextStyle(
//                  // 1の場合、選択された、1ではない場合、選択されてない
//                  color: _currentIndex != 2 ? _defaultColor : _activeColor,
//                ),
//              )),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.account_circle,
//                color: _defaultColor,
//              ),
//              activeIcon: Icon(
//                Icons.account_circle,
//                color: _activeColor,
//              ),
//              title: Text(
//                "mypage",
//                style: TextStyle(
//                  // 1の場合、選択された、1ではない場合、選択されてない
//                  color: _currentIndex != 3 ? _defaultColor : _activeColor,
//                ),
//              )),
        ],
      ),
    );
  }

  _bottomNavigationBarItem(String title, int index, int itemIndex) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        Icons.home,
        color: _activeColor,
      ),
      title: (Text(
        title,
        style: TextStyle(
          color: index != itemIndex ? _defaultColor : _activeColor,
        ),
      )),
    );
  }
}
