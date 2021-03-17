import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/help_screen.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              PageTransition(
                child: Dashboard(),
                type: PageTransitionType.fade,
              ),
            );
          }
          if (index == 1) {
            print("DUH");
          }
          if (index == 2) {
            Navigator.push(
              context,
              PageTransition(
                child: HelpScreen(),
                type: PageTransitionType.fade,
              ),
            );
          }
          if (index == 3) {}
          if (index == 4) {}
        },
        elevation: 100.0,
        selectedItemColor: Color(0xff0c18fb),
        // selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          size: 26,
        ),
        unselectedIconTheme: IconThemeData(
          size: 23,
        ),
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              AntDesign.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Info",
            icon: Icon(
              AntDesign.infocirlce,
            ),
          ),
          BottomNavigationBarItem(
            label: "Help",
            icon: Icon(
              AntDesign.phone,
            ),
          ),
          BottomNavigationBarItem(
            label: "Share",
            icon: Icon(
              AntDesign.sharealt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              AntDesign.user,
            ),
          ),
        ],
      ),
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
