import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/widget/load_container.dart';
import 'package:flutter_trip/widget/web_view.dart';

const _TRAVEL_URL =
    "https://m.ctrip.com/webapp/you/livestream/paipai/home.html?Id=0&districtId=-1&autoawaken=close&popup=close&isHideHeader=true&isHideNavBar=YES&s_guid=851ed907-1b92-4e61-95fd-2d169ab3ee6f";
const PAGE_SIZE = 10;

class TravelTabPages extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;
  final Map params;

  const TravelTabPages(
      {Key key, this.travelUrl, this.params, this.groupChannelCode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TravelTabPagesState();
}

class _TravelTabPagesState extends State<TravelTabPages>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems;
  int pageIndex = 1;

  //页面下啦刷新
  bool _loading = true;

  //页面向下滑动刷新
  ScrollController _scrollController = ScrollController();

  // 保持 前面页面内容
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: LoadContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _handleRefersh,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                crossAxisCount: 4,
                itemCount: travelItems?.length ?? 0,
                itemBuilder: (BuildContext context, int index) => _TravelItem(
                  index: index,
                  item: travelItems[index],
                ),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              )),
        ),
      ),
    );
  }

  _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.groupChannelCode,
            pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
      _loading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      _loading = false;
      print(e);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];

    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });

    return filterItems;
  }

  Future<Null> _handleRefersh() async {
    _loadData();
    return null;
  }

//  List<TravelItem> _filterItems(List<TravelItem> resultList) {
//    if (resultList == null) {
//      return [];
//    }
//    List<TravelItem> filterItems = [];
//    resultList.forEach((item) {
//      if (item.article != null) {
//        //移除article为空的模型
//        filterItems.add(item);
//      }
//    });
//    return filterItems;
//  }
}

class _TravelItem extends StatelessWidget {
  final TravelItem item;
  final int index;

  _TravelItem({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
//      onTap: () {
//        if (item.article.urls != null && item.article.urls.length > 0) {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => WebView(
//                        url: item.article.urls[0].h5Url,
//                        title: "xiangqing",
//                      )));
//        }
//      },
      onTap: () {
        if (item.article.urls != null && item.article.urls.length > 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: item.article.urls[0].h5Url,
                        title: '详情',
                      )));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  String _poiName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? "no more"
        : item.article.pois[0]?.poiName ?? "no more";
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: 90,
                child: Text(
                  item.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//class _TravelTabPagesState extends State<TravelTabPages> {
//  List<TravelItem> travelItems;
//  int pageIndex = 1;
//
//  @override
//  void initState() {
//    _loadData();
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: StaggeredGridView.countBuilder(
//      crossAxisCount: 4,
//      itemCount: travelItems?.length ?? 0,
//      itemBuilder: (BuildContext context, int index) => _TravelItem(
//        index: index,
//        item: travelItems[index],
//      ),
//      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
//    ));
//  }
//
//  void _loadData() {
//    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.groupChannelCode,
//            pageIndex, PAGE_SIZE)
//        .then((TravelItemModel model) {
//      setState(() {
//        List<TravelItem> items = _filterItems(model.resultList);
//        if (travelItems != null) {
//          travelItems.addAll(items);
//        } else {
//          travelItems = items;
//        }
//      });
//    }).catchError((e) {
//      print(e);
//    });
//  }
//
//  List<TravelItem> _filterItems(List<TravelItem> resultList) {
//    if (resultList == null) {
//      return [];
//    }
//    List<TravelItem> filterItems = [];
//    resultList.forEach((item) {
//      if (item.article != null) {
//        //移除article为空的模型
//        filterItems.add(item);
//      }
//    });
//    return filterItems;
//  }
//}

//class _TravelItem extends StatelessWidget {
//  final TravelItem item;
//  final int index;
//
//  const _TravelItem({Key key, this.item, this.index}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text('$index'),
//    );
//  }
//}

//class TravelTabPages extends StatefulWidget {
//  final String travelUrl;
//  final String groupChannelCode;
//
//  const TravelTabPages({Key key, this.travelUrl, this.groupChannelCode})
//      : super(key: key);
//
//  @override
//  _TravelTabPagesState createState() => _TravelTabPagesState();
//}
