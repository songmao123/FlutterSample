import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_app/content.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _logoAnimationController;
  Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOut,
    );
    _logoAnimation.addListener(() => this.setState(() {}));
    _logoAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        child: LoginBody(logoAnimation: _logoAnimation),
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
    @required Animation<double> logoAnimation,
  })  : _logoAnimation = logoAnimation,
        super(key: key);

  final Animation<double> _logoAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                ),
                FlutterLogo(
                  size: _logoAnimation.value * 100,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Theme(
                data: ThemeData(
                  hintColor: Colors.teal[300],
                  primarySwatch: Colors.teal,
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white70),
                          labelText: 'Enter your email',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white70,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.teal,
                        ),
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white70),
                          labelText: 'Enter your password',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white70,
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.teal,
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          textColor: Colors.white70,
                          padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainApp(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
