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

class LoginBody extends StatefulWidget {
  final Animation<double> _logoAnimation;

  LoginBody({
    Key key,
    @required Animation<double> logoAnimation,
  })  : _logoAnimation = logoAnimation,
        super(key: key);

  @override
  LoginBodyState createState() => LoginBodyState();
}

class LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email, _password;
  bool _validate = false;
  bool _raisedButtonState = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_formEditAction);
    _passwordController.addListener(_formEditAction);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
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
                  size: widget._logoAnimation.value * 100,
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
                  key: _formKey,
                  autovalidate: _validate,
                  child: formUI(),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Column formUI() {
    return Column(
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
          validator: _validEmail,
          onSaved: (String value) {
            _email = value;
          },
          controller: _emailController,
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
          validator: _validPassowrd,
          onSaved: (String value) {
            _password = value;
          },
          controller: _passwordController,
        ),
        SizedBox(
          height: 60.0,
        ),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            color: Colors.teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            disabledColor: Colors.grey[400],
            textColor: Colors.white70,
            disabledTextColor: Colors.white70,
            padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: _raisedButtonState ? _validParams : null,
          ),
        )
      ],
    );
  }

  String _validEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  void _validParams() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainApp(),
        ),
      );
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String _validPassowrd(String value) {
    if (value.length < 6) {
      return 'Password length must greater than 6';
    }
    return null;
  }

  void _formEditAction() {
    bool valid =
        _emailController.text.length > 0 && _passwordController.text.length > 0;
    setState(() {
      _raisedButtonState = valid;
    });
  }
}
