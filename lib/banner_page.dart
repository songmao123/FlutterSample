import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/banner/banner.dart';
import 'package:flutter_app/banner/banner_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        bannerWidget(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Dialog Display',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
          ),
        ),
        DialogWidget(),
      ],
    );
  }

  Widget bannerWidget() {
    return FutureBuilder<BannerData>(
      future: fetchBanner(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BannerWidget(bannerList: snapshot.data.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class DialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return loadingDialogWidget(context);
  }

  Widget loadingDialogWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        RaisedButton(
          child: Text('ShowLoadingDialog'),
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: () {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  backgroundColor: Color(0x80000000),
                  elevation: 0.0,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 16.0),
                        Container(
                          width: 60.0,
                          height: 60.0,
                          child: SvgPicture.asset(
                            'assets/ic_dbc_logo.svg',
                            color: Color(0xCCFFFFFF),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        IndicatorWidget(),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class IndicatorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndicatorWidgetState();
}

class IndicatorWidgetState extends State<IndicatorWidget>
    with TickerProviderStateMixin {
  Timer _timer;
  int _currentIndex = 0;
  // Animation<int> animation;
  // AnimationController animationController;

  @override
  void initState() {
    // animationController = AnimationController(
    //     duration: const Duration(milliseconds: 2000), vsync: this);
    // final curve =
    //     CurvedAnimation(parent: animationController, curve: Curves.linear);
    // animation = IntTween(begin: 0, end: 2).animate(curve)
    //   ..addListener(() {
    //     setState(() {
    //       _currentIndex = animation.value;
    //       print('Animation value: $_currentIndex');
    //     });
    //   });
    // animationController.addStatusListener((state) {
    //   if (state == AnimationStatus.completed) {
    //     print('Animation completed.');
    //     animationController.reset();
    //     animationController.forward();
    //   }
    // });
    // // animationController.addListener(() {});
    // animationController.forward();
    _timer = Timer.periodic(Duration(milliseconds: 350), (timer) {
      setState(() {
        _currentIndex++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // animationController.dispose();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return indicatorWidget();
  }

  Widget indicatorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _dotList(),
    );
  }

  List<Widget> _dotList() {
    List<Widget> dotList = [];
    for (var i = 0; i < 3; i++) {
      dotList.add(Container(
        margin: EdgeInsets.all(5.0),
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == (_currentIndex % 3) ? Colors.white : Color(0x4dffffff),
        ),
      ));
    }
    return dotList;
  }
}
