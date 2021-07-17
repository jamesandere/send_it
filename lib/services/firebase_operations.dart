import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:send_it/utils/home_utils.dart';

import 'authentication.dart';



class FirebaseOperations extends ChangeNotifier {
  UploadTask? imageUploadTask;

  
  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance.collection('users').doc(auth.getUserUid).set(data);
  }

  Future updateUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance.collection('users').doc(auth.getUserUid).update(data);
  }

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'userProfilePic/${homeUtils.getUserAvatar!.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(homeUtils.getUserAvatar!);
    await imageUploadTask!.whenComplete((){
      print('image uploaded');
    });
    imageReference.getDownloadURL().then((url){
      homeUtils.userAvatarUrl = url.toString();
    });
  }
}

final auth = Authentication();
final homeUtils = HomeUtils();

final firebaseModel = ChangeNotifierProvider<FirebaseOperations>((ref) {
  print('>>> In firebaseModel');
  return FirebaseOperations();
});