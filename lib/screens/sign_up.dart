import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:send_it/screens/home_page.dart';
import 'package:send_it/screens/profile_pic.dart';
import 'package:send_it/services/authentication.dart';
import 'package:send_it/services/firebase_operations.dart';

class SignUp extends HookWidget {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authenticationModel);
    final firebase = useProvider(firebaseModel);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 40.0,),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    // color: Colors.pink,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: userEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter email',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    // color: Colors.pink,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: userPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    // color: Colors.pink,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          if(usernameController.text.isNotEmpty){
           await  auth.createAccount(userEmailController.text, userPasswordController.text).whenComplete(() {
              firebase.createUserCollection(context, {
                "useruid" : auth.getUserUid,
                "username" : usernameController.text,
                "useremail" : userEmailController.text,
                "displayname" : userEmailController.text.replaceAll("@gmail.com", ""),
                "userpassword" : userPasswordController.text,
              });
            }).whenComplete(() {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProfilePic();
              }));
            });
          }
        },
        backgroundColor: Colors.black,
        child: Icon(
          EvaIcons.arrowForward,
        ),
      ),
    );
  }
}
