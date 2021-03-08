import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/helpers/complaint.dart';

class DashboardProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  String userID;

  List<String> areas_of_concern = [
    'Electrical',
    'Health and Sanitation',
    'Entomology',
    'Revenue',
    'Veterinary',
    'Urban Biodiversity',
    'Information Technology'
  ];
}
