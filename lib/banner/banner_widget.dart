import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/banner/banner.dart';

const TOTAL_PAGE_COUNT = 100000;

class BannerWidget extends StatefulWidget {
  final List<BannerItem> bannerList;

  BannerWidget({
    Key key,
    @required this.bannerList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BannerWidgetState();
}

class BannerWidgetState extends State<BannerWidget> {
  Timer _timer;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    double current = TOTAL_PAGE_COUNT / 2 -
        (TOTAL_PAGE_COUNT / 2) % widget.bannerList.length;
    _pageController = PageController(
      initialPage: current.toInt(),
      viewportFraction: 1.0,
    );
    startLoop();
    super.initState();
  }

  void startLoop() {
    stopLoop();
    _timer = Timer.periodic(Duration(milliseconds: 5000), (timer) {
      print('Timer is comming...');
      _pageController.animateToPage(
        _pageController.page.toInt() + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  void stopLoop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: Stack(
        children: <Widget>[
          vierPagerWidget(),
          indicatorWidget(),
        ],
      ),
    );
  }

  Widget vierPagerWidget() {
    return PageView.builder(
      itemCount: TOTAL_PAGE_COUNT,
      controller: _pageController,
      onPageChanged: _pageChanged,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  widget.bannerList[index % widget.bannerList.length].imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ));
      },
    );
  }

  Widget indicatorWidget() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _dotList(),
        ),
      ),
    );
  }

  List<Widget> _dotList() {
    List<Widget> dotList = [];
    for (var i = 0; i < widget.bannerList.length; i++) {
      dotList.add(Container(
        margin: EdgeInsets.all(3.0),
        width: 6.0,
        height: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == _currentIndex ? Colors.teal : Colors.grey[300],
        ),
      ));
    }
    return dotList;
  }

  void _pageChanged(int value) {
    _currentIndex = value % widget.bannerList.length;
    setState(() {});
  }

  @override
  void dispose() {
    stopLoop();
    super.dispose();
  }
}
