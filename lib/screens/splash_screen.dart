import 'dart:async';

import 'package:flutter/material.dart';
import 'package:send_it/screens/home_page.dart';
import 'package:send_it/screens/sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
      Duration(seconds: 3), (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SignIn();
        }));
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VxAnimatedBox()
          .size(context.screenWidth, context.screenHeight)
          .withGradient(LinearGradient(
            colors: [
              Color(0xFF005746),
              Color(0xFF010504),
            ],
            begin:  Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5],
          ),).make(),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      color: Color(0xFF179C49),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.send,
                  ),
                ),
                SizedBox(width: 8.0,),
                "Send It".text.white.bold.xl3.make(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
