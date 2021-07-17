import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui' as ui;

import 'package:send_it/screens/sign_up.dart';
import 'package:send_it/services/authentication.dart';

import 'home_page.dart';

class SignIn extends HookWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authenticationModel);
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(color: Colors.red,
                    //   alignment: Alignment.topCenter,
                    //   child: Image.network('https://ouch-cdn2.icons8.com/ewutdp6t4dfvwFGZsTwvTxPznxBK2U1RAWIiYtDtTDw/rs:fit:874:912/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzky/LzA3OGNiYWFjLTQ3/MmMtNDMwNC05Mzhi/LTllM2VkMWU2Zjgy/Ni5zdmc.png',
                    //   height: 300.0,
                    //     width: 300.0,
                    //   ),
                    // ),
                    // SizedBox(height: 30.0,),
                    Container(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter email"
                            ),
                            controller: userEmailController,
                          ),
                          SizedBox(height: 20.0,),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Enter password"
                            ),
                            controller: userPasswordController,
                          ),
                          MaterialButton(
                            onPressed: (){
                              if(userEmailController.text.isNotEmpty){
                                auth.loginViaEmail(userEmailController.text, userEmailController.text).whenComplete(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Home();
                                  }));
                                });
                              }
                            },
                            color: Colors.black,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0,),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Sign In with:',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return SignUp();
                                    }));
                                  },
                                  child: Icon(
                                    Icons.email,
                                    size: 30.0,
                                  ),
                                ),
                                MaterialButton(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {
                                    // Authentication().signInWithGoogle();
                                    auth.signInWithGoogle();
                                  },
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return ui.Gradient.linear(
                                        Offset(4.0, 24.0),
                                        Offset(24.0, 4.0),
                                        [
                                          Colors.deepPurple,
                                          Colors.deepOrangeAccent,
                                        ],
                                      );
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.google,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  shape: CircleBorder(),
                                  color: Colors.red,
                                  padding: EdgeInsets.all(20),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.facebook,
                                    size: 30.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
