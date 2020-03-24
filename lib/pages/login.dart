import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  List<String> _list = ["商品", "评论", "详情", "推荐"];

  ItemScrollController _scrollController;
  TabController _tabController;

  double scrollHeight = 0.0;
  double appbarOpctity = 0.0;
  bool isDispalyTab = true;

  double onePoition = 0.0;
  double twoPoition = 0.0;
  double therePoition = 0.0;
  double fourPosition = 0.0;
  double appbarheight = MediaQueryData.fromWindow(window).padding.top + 40;

  @override
  void initState() {
    _scrollController = ItemScrollController();
    _tabController = TabController(vsync: this, length: _list.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) =>
                buildCustomerAppBar(scrollNotification),
            child: ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) =>
                    itemBuilder(context, index)),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: MediaQueryData.fromWindow(window).padding.top),
            height: MediaQueryData.fromWindow(window).padding.top + 40,
            color: Colors.white.withOpacity(appbarOpctity),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: appbarOpctity <= 0.3
                                    ? Colors.black26
                                    : Colors.transparent,
                                shape: BoxShape.circle),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                              color: appbarOpctity >= 0.3
                                  ? Colors.black.withOpacity(appbarOpctity)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Offstage(
                        offstage: isDispalyTab,
                        child: Opacity(
                          opacity: appbarOpctity,
                          child: Container(
                            height: 30,
                            child: TabBar(
                              onTap: (index) {
                                print(_tabController.indexIsChanging);
                                _scrollController.scrollTo(index: index, duration: Duration(milliseconds: 200));
                              },
                              labelColor: Colors.black,
                              controller: _tabController,
                              tabs: _list
                                  .map((val) => Text(
                                        val,
                                        style: TextStyle(color: Colors.black),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: appbarOpctity <= 0.3
                                    ? Colors.black26
                                    : Colors.transparent,
                                shape: BoxShape.circle),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.share,
                              color: appbarOpctity >= 0.3
                                  ? Colors.black.withOpacity(appbarOpctity)
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: appbarOpctity <= 0.3
                                    ? Colors.black26
                                    : Colors.transparent,
                                shape: BoxShape.circle),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.linear_scale,
                              color: appbarOpctity >= 0.3
                                  ? Colors.black.withOpacity(appbarOpctity)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          var username = 'leoyao';
          Navigator.pushReplacementNamed(context, 'home/$username');
        },
      ),
    );
  }

  itemBuilder(context, index) {
    Widget con;
    if (index == 0)
      con = NotificationListener<CustomerNotification>(
          onNotification: (notification) {
            print("这是当前位置");
            setState(() {
              onePoition = notification.position;
            });
          },
          child: GoodsInfoPage());
    else if (index == 1) {
      con = NotificationListener<CustomerNotification>(
          onNotification: (notification) {
            print(notification.position);
            print("这是当前位置");
            setState(() {
              twoPoition = notification.position;
            });
          },
          child: CommentPage());
    } else if (index == 2)
      con = NotificationListener<CustomerNotification>(
          onNotification: (notification) {
            print("这是当前位置");
            setState(() {
              therePoition = notification.position;
            });
          },
          child: DetailPage());
    else
      con = NotificationListener<CustomerNotification>(
          onNotification: (notification) {
            print("这是当前位置");
            setState(() {
              fourPosition = notification.position;
            });
          },
          child: RecommendPage());

    return con;
  }

  bool buildCustomerAppBar(scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification &&
        scrollNotification.depth == 0) {
      double pixels = scrollNotification.metrics.pixels;
//      print(pixels.toString() + "---" + onePoition.toString() +
//          "---" + twoPoition.toString() + "---" + therePoition.toString()
//          + "---" + fourPosition.toString() );

      if (pixels >= onePoition && pixels < twoPoition - appbarheight) {
        _tabController.animateTo(0,
            duration: Duration(microseconds: 2000), curve: Curves.easeInOut);
      } else if (pixels >= twoPoition && pixels < therePoition - appbarheight) {
        _tabController.animateTo(1,
            duration: Duration(microseconds: 2000), curve: Curves.easeInOut);
      } else if (pixels >= therePoition - appbarheight &&
          pixels < fourPosition - appbarheight) {
        _tabController.animateTo(2,
            duration: Duration(microseconds: 2000), curve: Curves.easeInOut);
      } else if (pixels >= fourPosition - appbarheight) {
        _tabController.animateTo(3,
            duration: Duration(microseconds: 2000), curve: Curves.easeInOut);
      }

      double opcity = pixels / 100;
      if (opcity < 1 && opcity > 0) {
        setState(() {
          appbarOpctity = opcity;
          isDispalyTab = opcity > 0.3 ? false : true;
        });
      } else if (opcity <= 0) {
        setState(() {
          appbarOpctity = 0.0;
          isDispalyTab = opcity > 0.3 ? false : true;
        });
      } else if (opcity > 1) {
        setState(() {
          appbarOpctity = 1.0;
          isDispalyTab = opcity > 0.3 ? false : true;
        });
      }
    }
    return true;
  }
}

class GoodsInfoPage extends StatefulWidget {
  @override
  _GoodsInfoPageState createState() => _GoodsInfoPageState();
}

class _GoodsInfoPageState extends State<GoodsInfoPage> {
  GlobalKey _keyBule = GlobalKey();
  List<String> goodsImgs = [
    "assets/WechatIMG5.jpeg",
    "assets/WechatIMG1.jpeg",
    "assets/WechatIMG2.jpeg",
    "assets/WechatIMG3 1.jpeg",
    "assets/WechatIMG4.jpeg"
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    CustomerNotification(positionRed.dy).dispatch(context);
    print("POSITION of Red: $positionRed.dy");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: _keyBule,
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Swiper(
                itemCount: goodsImgs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    goodsImgs[index],
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
            builderGoodsInfo()
          ],
        ));
  }

  Widget builderGoodsInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  style: TextStyle(color: Color.fromRGBO(229, 62, 39, 1)),
                  children: [
                    TextSpan(text: "¥", style: TextStyle(fontSize: 17)),
                    TextSpan(text: "68", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    TextSpan(text: ".00", style: TextStyle(fontSize: 17))
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.control_point_duplicate),
                      new Text("降价通知",style: TextStyle(fontSize: 12,color: Colors.grey))
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: <Widget>[
                      Icon(Icons.color_lens),
                      new Text("0.4万",style: TextStyle(fontSize: 12,color: Colors.grey))
                    ],
                  ),
                ],
              ),
            ],
          ),
         Container(
           height: 120,
           child:  Image.asset("assets/12332.png",fit: BoxFit.fill),
         ),
          Container(
            height: 130,
            margin: EdgeInsets.only(top: 20),
            child:  Image.asset("assets/12323.png",fit: BoxFit.fill),
          ),
          Container(
            height: 180,
            margin: EdgeInsets.only(top: 20),
            child:  Image.asset("assets/WechatIMG9.jpeg",fit: BoxFit.fill),
          ),
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 20),
            child:  Container(
                child: Image.asset("assets/WechatIMG10.jpeg",height:20,fit: BoxFit.fill)
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey _keyBule = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    CustomerNotification(positionRed.dy).dispatch(context);
    print("POSITION of Red: $positionRed ");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyBule,
      color: Colors.black26,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: new Text("详情"),
            );
          }),
    );
  }
}

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  GlobalKey _keyBule = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
    print(sizeRed.height);
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed ");
    CustomerNotification(positionRed.dy).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      key: _keyBule,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 600,
            child:  Image.asset("assets/WechatIMG12.jpeg",fit: BoxFit.fill),
          ),
          Container(
            height: 200,
            child:  Image.asset("assets/WechatIMG14.jpeg",fit: BoxFit.fill),
          ),
        ],
      ),
    );
  }
}

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  GlobalKey _keyBule = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyBule.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of Red: $positionRed.dy ");
    CustomerNotification(positionRed.dy).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyBule,
      color: Colors.amber,
      child: Container(
        height: 900,
        width: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class CustomerNotification extends Notification {
  CustomerNotification(this.position);
  final double position;
}
