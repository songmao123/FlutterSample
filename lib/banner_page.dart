import 'package:flutter/material.dart';
import 'package:flutter_app/banner/banner.dart';
import 'package:flutter_app/banner/banner_widget.dart';

class BannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner Page"),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: BannerBody(),
      ),
    );
  }
}

class BannerBody extends StatelessWidget {
  final List<BannerItem> bannerList = [
    BannerItem(
      desc: '一起来做个App吧',
      id: 10,
      imagePath:
          'http://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png',
      isVisible: 1,
      order: 3,
      title: '一起来做个App吧',
      type: 0,
      url: 'http://www.wanandroid.com/blog/show/2',
    ),
    BannerItem(
      desc: '看看别人的面经，搞定面试',
      id: 4,
      imagePath:
          'http://www.wanandroid.com/blogimgs/ab17e8f9-6b79-450b-8079-0f2287eb6f0f.png',
      isVisible: 1,
      order: 0,
      title: '看看别人的面经，搞定面试',
      type: 1,
      url: 'http://www.wanandroid.com/article/list/0?cid=73',
    ),
    BannerItem(
      desc: '兄弟，要不要挑个项目学习下?',
      id: 3,
      imagePath:
          'http://www.wanandroid.com/blogimgs/fb0ea461-e00a-482b-814f-4faca5761427.png',
      isVisible: 1,
      order: 1,
      title: '一起来做个App吧',
      type: 1,
      url: 'http://www.wanandroid.com/project',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Banner Display',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
          ),
        ),
        BannerWidget(bannerList: bannerList),
      ],
    );
  }
}
