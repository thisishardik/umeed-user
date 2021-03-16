import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:umeed_user_app/providers/bottom_navigation_provider.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'file:///F:/Android/AndroidStudioProjects/umeed_user_app/umeed_user_app/lib/screens/grievance/post_grievance_screen.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:umeed_user_app/screens/info_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var currentTab = [
    Dashboard(),
    InfoScreen(),
    HelpScreen(),
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
    return BottomNavigationBar(
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
    );
  }
}
