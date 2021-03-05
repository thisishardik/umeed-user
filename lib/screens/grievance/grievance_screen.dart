import 'package:flutter/material.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';

class GrievanceScreen extends StatefulWidget {
  @override
  _GrievanceScreenState createState() => _GrievanceScreenState();
}

class _GrievanceScreenState extends State<GrievanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: Container(
          height: 50.0,
          color: Colors.orange,
          child: Text(
            'GRIEVANCE PAGE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
