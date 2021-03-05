import 'package:flutter/material.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: Container(
          height: 50.0,
          color: Colors.red,
          child: Text(
            'HELP PAGE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
