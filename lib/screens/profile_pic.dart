import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:send_it/utils/home_utils.dart';


class ProfilePic extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final homeUtils = useProvider(homeUtilsModel);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a Profile photo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                // Provider.of<LandingUtils>(context, listen: false).selectAvatarSheet(context);
                homeUtils.selectAvatarSheet(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent.withOpacity(0.2),
                // backgroundImage: ,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 50.0,
                ),
                radius: 80.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Skip',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
