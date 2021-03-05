import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String uid;
  String name;
  String email;
  String password;
  String username;
  String dob;
  String gender;
  String contact;
  String errorMessage;

  void printDetails() {
    print({
      'uid': uid,
      'name': name,
      'dob': dob,
      'contact': contact,
      'email': email,
      'gender': gender,
      'username': username,
    }.toString());
  }

  String validate() {
    printDetails();

    if (name == null || dob == "" || contact == null || email == null) {
      return "Fields must not be empty";
    }
    if (!name.contains(new RegExp(r'[A-Za-z]'))) {
      return "Invalid Name";
    }
    if (!contact.contains(new RegExp(r'^-?[0-9]+$')) || contact.length != 10) {
      return "Invalid Mobile number";
    }
    if (!email.contains(RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$"))) {
      return "Invalid Email address";
    }
    return "pass";
  }

  addUserToDB() async {
    const url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/profile";
    // var data = new Map<String, dynamic>();
    // data['uid'] = uid;
    // data['name'] = name;
    // data['email'] = email;
    // data['username'] = username;
    // data['dob'] = dob;
    // data['gender'] = gender;
    // data['contact'] = contact;
    Map<String, String> headers = {"Content-type": "application/json"};

    String json =
        '{"uid":"$uid","name":"$name","email":"$email","username":"$username","dob":"$dob","gender":"$gender","contact":"$contact"}';

    final response = await http.post(url, body: json, headers: headers);
    //print("auth"+response.statusCode.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return response.statusCode;
    }
    notifyListeners();
  }
}
