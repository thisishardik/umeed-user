import 'package:flutter/material.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: Container(
          height: 50.0,
          color: Colors.red,
          child: Text(
            'INFO PAGE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
