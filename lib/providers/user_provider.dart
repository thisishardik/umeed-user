import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/helpers/complaint.dart';

class UserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  String userID;
  AppUser _userData;

  AppUser get userData => _userData;

  Future<AppUser> getUserProfileData() async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      userID = loggedInUser.uid;
      print("USER ID IS : $userID");
    }
    String url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/profile/$userID";

    final response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> extractedUserData = jsonDecode(response.body);
    // print(map);
    // final extractedUserData = map['data'];
    // print("EXTRACTED USER DATA $extractedUserData");
    // print("UID IS ${extractedUserData['uid']}");
    _userData = AppUser(
        uid: extractedUserData['uid'],
        name: extractedUserData['name'],
        dob: extractedUserData['dob'],
        contact: extractedUserData['contact'],
        email: extractedUserData['email'],
        gender: extractedUserData['gender'],
        username: extractedUserData['username']);
    notifyListeners();
    // print("USER DATA FROM FUNCTION $_userData");
    return _userData;
  }
}
