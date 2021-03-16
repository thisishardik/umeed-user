import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HelpProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  String userID;

  List<String> helpline_services = [
    'NATIONAL EMERGENCY NUMBER',
    'POLICE',
    'Entomology',
    'Revenue',
    'Veterinary',
    'Urban Biodiversity',
    'Information Technology'
  ];
  List<String> helpline_numbers = [
    '112',
    '100',
    'Entomology',
    'Revenue',
    'Veterinary',
    'Urban Biodiversity',
    'Information Technology'
  ];
}
