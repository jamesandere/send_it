import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:send_it/screens/home_page.dart';
import 'package:send_it/services/authentication.dart';
import 'package:send_it/services/firebase_operations.dart';

class HomeUtils extends ChangeNotifier {
  final picker = ImagePicker();
  File? userAvatar;
  File? get getUserAvatar => userAvatar;
  String? userAvatarUrl;
  String? get getUserAvatarUrl => userAvatarUrl;
  UploadTask? imageUploadTask;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null ? print('select image') : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar!.path);
    userAvatar != null ? showUserAvatar(context) : print('Image uploaded');
  }

  uploadUserAvatar(BuildContext context) async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfilePic/${userAvatar!.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(userAvatar!);
    await imageUploadTask!.whenComplete((){
    print('image uploaded');
    });
    imageReference.getDownloadURL().then((url){
    userAvatarUrl = url.toString();
    });
  }

  Future updateUserCollection(BuildContext context, dynamic data) async {
    var coll = await FirebaseFirestore.instance.collection('users').doc(authentication.getUserUid).get();
      if(coll.exists){
        return await FirebaseFirestore.instance.collection('users').doc(authentication.getUserUid).update(data);
      }

    else{
      print('can\'t update');
    }
  }

  Future selectAvatarSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    pickUserAvatar(context, ImageSource.gallery)
                        .whenComplete(() {
                      Navigator.pop(context);
                      // Provider.of<LandingHelpers>(context, listen: false).showUserAvatar(context);
                      showUserAvatar(context);
                    });
                  },
                  child: Text(
                    'Gallery',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    pickUserAvatar(context, ImageSource.camera)
                        .whenComplete(() {
                      Navigator.pop(context);
                      // Provider.of<LandingHelpers>(context, listen: false).showUserAvatar(context);
                      showUserAvatar(context);

                    });
                  },
                  child: Text(
                    'Camera',
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  showUserAvatar(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: FileImage(
                    userAvatar!,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                          selectAvatarSheet(context);
                        },
                        child: Text(
                          'Reselect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: (){
                          // Navigator.pop(context);
                          //  firebaseModel.uploadUserAvatar(context).whenComplete((){
                          //   proceedSheet(context);
                          // });
                          uploadUserAvatar(context).whenComplete((){
                            proceedSheet(context);
                          });
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  proceedSheet(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You\'re good to go!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 20.0,),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: FileImage(
                  userAvatar!,
                ),
              ),
              MaterialButton(
                onPressed: (){
                  // firebaseModel.updateUserCollection(context, {
                  //   "useravatar" : getUserAvatarUrl,
                  // }).whenComplete((){
                  //   firebaseModel.uploadUserAvatar(context);
                  // });
                  // firebaseModel.uploadUserAvatar(context).whenComplete((){
                  //   firebaseModel.updateUserCollection(context, {
                  //     "useravatar" : getUserAvatarUrl,
                  //   });
                  // });
                  updateUserCollection(context, {
                    "useravatar" : userAvatarUrl,
                  }).whenComplete((){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Home();
                    }));
                  });
                },
                child: Text(
                  'Finish',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}




final homeUtilsModel = ChangeNotifierProvider<HomeUtils>((ref) {
  print('>>> In firebaseModel');
  return HomeUtils();
});

// final firebaseModel = FirebaseOperations();
final authentication = Authentication();