import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:send_it/services/shared_pref.dart';

class Authentication extends ChangeNotifier{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? userUid;
  String? get getUserUid => userUid;

  // getCurrentUser() async {
  //   return auth.currentUser;
  // }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    userUid = user!.uid;
    print(userUid);

    if(userCredential != null){
      SharedPrefHelper().saveUserEmail(user.email!);
      SharedPrefHelper().saveUserName(user.email!.replaceAll("@gmail.com", ""));
      SharedPrefHelper().saveDisplayName(user.displayName!);
      SharedPrefHelper().saveUserId(user.uid);
      SharedPrefHelper().saveUserProfilePic(user.photoURL!);
    }
  }

  Future loginViaEmail(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    userUid = user!.uid;
  }

  Future logOutViEmail(){
    return auth.signOut();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    final UserCredential userCredential = await auth.signInWithCredential(authCredential);
    final User? user = userCredential.user;
    userUid = user!.uid;

    if(userCredential != null){
      SharedPrefHelper().saveUserEmail(user.email!);
      SharedPrefHelper().saveUserName(user.email!.replaceAll("@gmail.com", ""));
      SharedPrefHelper().saveDisplayName(user.displayName!);
      SharedPrefHelper().saveUserId(user.uid);
      SharedPrefHelper().saveUserProfilePic(user.photoURL!);
    }
  }

  Future signOutWithGoogle(){
    return googleSignIn.signOut();
  }
}


final authenticationModel = ChangeNotifierProvider<Authentication>((ref) {
  print('>>> In authenticationModel');
  return Authentication();
});