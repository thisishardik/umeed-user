import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/dashboard_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umeed_user_app/screens/grievance/post_complaint_screen.dart';
import 'package:umeed_user_app/screens/grievance/post_grievance_screen.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const curveHeight = 28.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Success Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Container(
              height: 150.0,
              width: 150.0,
              color: Colors.orange,
              child: Text('SUCCESS'),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
