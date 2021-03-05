import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var pages = [SignInScreen(), Dashboard()];
  int pageIndex = 0;
  final _auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    var currentUser;
    currentUser = _auth.currentUser;
    if (_auth.currentUser != null) {
      setState(() {
        pageIndex = 1;
      });
    }
    return currentUser;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pages[pageIndex],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Image(
                image: AssetImage("assets/images/splash.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
