import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:umeed_user_app/providers/bottom_navigation_provider.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'file:///F:/Android/AndroidStudioProjects/umeed_user_app/umeed_user_app/lib/screens/grievance/post_grievance_screen.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var currentTab = [
    Dashboard(),
    HelpScreen(),
    PostGrievanceScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var bottomNavBarProvider = Provider.of<BottomNavigationProvider>(context);
    return Theme(
      data: ThemeData(canvasColor: Color(0xffffefef)),
      child: CustomNavigationBar(
        currentIndex: bottomNavBarProvider.currentIndex,
        onTap: (index) {
          bottomNavBarProvider.currentIndex = index;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    currentTab[bottomNavBarProvider.currentIndex],
              ),
              (route) => true);
        },
        elevation: 8.0,
        iconSize: 26.5,
        selectedColor: Color(0xff0c18fb),
        strokeColor: Color(0x300c18fb),
        unSelectedColor: Colors.grey[600],
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(
            icon: Icon(
              AntDesign.home,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              AntDesign.infocirlce,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              AntDesign.phone,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              AntDesign.sharealt,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              AntDesign.user,
            ),
          ),
        ],
      ),
    );
  }
}
