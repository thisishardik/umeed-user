import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
