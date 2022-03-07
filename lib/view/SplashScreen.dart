import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences.dart';


class Splash extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  bool _loggedIn = false;
  final splashDelay = 3;


  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();

   // _checkLoggedIn();
    _loadWidget();
  }

  _checkLoggedIn() async {
    var _isLoggedIn;
    Preference().getPreferences().then((prefs) {
       _isLoggedIn = prefs.getBool('logged_in');
      print(_isLoggedIn);
    });


    if (_isLoggedIn == true) {
      setState(() {
        _loggedIn = _isLoggedIn!;
      });
    } else {
      setState(() {
        _loggedIn = false;
      });
    }
  }
  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => homeOrLog()));
  }

  Widget homeOrLog() {
    return Container();
    // if (this._loggedIn) {
    //   var obj = 0;
    //   return Dashboard(argument: {"currentIndex": "0"});
    // } else {
    //   return Login();
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body:
      Container(
        child: Center(
          child: Container(
            width: width * 0.9,
            height: height * 0.6,
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/logo.png',

            ),
          ),
        ),
      ),


    );
  }
}
