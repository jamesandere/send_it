import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPreferences preferences = SharedPreferences.getInstance() as SharedPreferences;

  static String userId = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String displayName = "USERDISPLAYNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";
  static String userPasswordKey = "USERPASSWORDKEY";

  Future<bool> saveUserName(String username) async {
    return preferences.setString(userNameKey, username);
  }

  Future<bool> saveUserEmail(String userEmail) async {
    return preferences.setString(userEmailKey, userEmail);
  }

  Future<bool> saveDisplayName(String displayName) async {
    return preferences.setString(displayName, displayName);
  }

  Future<bool> saveUserId(String userId) async {
    return preferences.setString(userId, userId);
  }

  Future<bool> saveUserProfilePic(String userProfilePic) async {
    return preferences.setString(userProfilePicKey, userProfilePic);
  }

  Future<bool> saveUserPassword(String password) async {
    return preferences.setString(userPasswordKey, password);
  }

  Future<String?> getUserName() async {
    return preferences.getString(userNameKey);
  }

  Future<String?> getUserId() async {
    return preferences.getString(userId);
  }

  Future<String?> getUserEmail() async {
    return preferences.getString(userEmailKey);
  }

  Future<String?> getDisplayName() async {
    return preferences.getString(displayName);
  }

  Future<String?> getUserProfilPic() async {
    return preferences.getString(userNameKey);
  }

  Future<String?> getUserPassword() async {
    return preferences.getString(userPasswordKey);
  }
}
