import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_it/screens/sign_in.dart';
import 'package:send_it/services/authentication.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authenticationModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF075B52),
        toolbarHeight: 80.0,
        leading: Icon(
          Icons.camera_alt,
        ),
        title: Text(
          'SendIt',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              auth.logOutViEmail().whenComplete(() {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SignIn();
                }));
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.logout,)),
          ),
        ],
      ),
      body: Column(
        children: [
          ChatTile(),

          ChatTile(),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network('https://pbs.twimg.com/profile_images/1396824090439204865/k3noK_Wn_400x400.jpg')),
          ),
          title: Text(
            'James Andere',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Did you go to the doctor?',
            style: TextStyle(

            ),
          ),
          trailing: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child: Text(
                  '12:01',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
      ],
    );
  }
}

