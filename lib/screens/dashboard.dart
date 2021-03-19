import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geocoder/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/auth_provider.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/announcements.dart';
import 'package:umeed_user_app/screens/grievance/area_of_concern.dart';
import 'file:///F:/Android/AndroidStudioProjects/umeed_user_app/umeed_user_app/lib/dummy/announcements_test.dart';
import 'package:umeed_user_app/screens/grievance/grievance_history.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/info_screen.dart';
import 'package:umeed_user_app/screens/news/news_home.dart';

class Dashboard extends StatefulWidget {
  static String id = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AppUser userData;
  AuthProvider authProvider;
  final _auth = FirebaseAuth.instance;
  int index = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  checkPermissions() async {
    GeolocatorPlatform.instance.requestPermission();
    await Permission.photos.request();
    await Permission.camera.request();
  }

  String uid = "";

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void initState() {
    super.initState();
    checkPermissions();
    Provider.of<UserProvider>(context, listen: false).getUserProfileData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userData = Provider.of<UserProvider>(context, listen: false).userData;
    // Provider.of<AuthProvider>(context, listen: false).printDetails();
    // authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          centerTitle: true,
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.adb),
              color: Colors.black,
              onPressed: () async {
                _showSnackBar(context, "Cache cleared");
                await DefaultCacheManager().emptyCache();
              },
            )
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            elevation: 20.0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                        radius: 47.0,
                      ),
                    ),
                    Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1.7,
                      ),
                    ),
                    Text(
                      'UMEED',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ListTile(
                      leading: Icon(
                        AntDesign.bells,
                        color: Colors.blueGrey,
                        size: 21.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Announcements",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnnouncementsScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.assignment_outlined,
                        color: Colors.blueGrey,
                        size: 22.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Grievance History",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrievanceHistory(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Colors.blueGrey,
                        size: 22.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Help",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        AntDesign.infocirlceo,
                        color: Colors.blueGrey,
                        size: 20.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "About",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                        leading: Icon(
                          AntDesign.logout,
                          color: Colors.blueGrey,
                          size: 20.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: () async {
                          await _auth.signOut();
                          Navigator.popAndPushNamed(context, '/login');
                        }),
                    SizedBox(height: 20.0),
                    Container(
                      height: 0.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30.0,
                  child: Text(
                    'Version 1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (index) {
            if (index == 0) {
              print("DUHH");
            }
            if (index == 1) {
              Navigator.push(
                context,
                PageTransition(
                  child: NewsHomeScreen(),
                  type: PageTransitionType.fade,
                ),
              );
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
              label: "News",
              icon: Icon(
                FontAwesome5.newspaper,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                ),
                constraints: BoxConstraints(
                  minHeight: 40.0,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: Text(
                        '10 people are using UMEED to solve their grievances.',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AreaOfConcernScreen(),
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AreaOfConcernScreen(),
                  //   ),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                          minHeight: 120.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  child: Text(
                                    'GRIEVANCES',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  'Post any of your daily life grievances\n in any sector.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Container(),
                            Container(),
                            Container(),
                            Image.asset(
                              "assets/images/grief.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: 120.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: Text(
                                  'CHECK STATUS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                'Check status of your registered\n complaints or applications.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(),
                          Container(),
                          Container(),
                          Image.asset(
                            "assets/images/grief.png",
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 120.0,
                            maxWidth: MediaQuery.of(context).size.width * 0.40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'WHERE I AM',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    'Explore government',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Container(),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 120.0,
                            maxWidth: MediaQuery.of(context).size.width * 0.40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'NEAR ME',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    'Find out things nearby your location',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Container(),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsHomeScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                          minHeight: 120.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  child: Text(
                                    'NewsByUmeed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Catch up with what's going on in the country",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Container(),
                            Container(),
                            Container(),
                            Image.asset(
                              "assets/images/grief.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 20.0),
              //   padding: const EdgeInsets.all(15.0),
              //   height: 400.0,
              //   color: Colors.grey[200],
              //   child: Stack(
              //     children: <Widget>[
              //       // Positioned(
              //       //   right: 15.0,
              //       //   top: 50.0,
              //       //   child: Image(
              //       //     image: AssetImage('assets/images/body_logo.png'),
              //       //   ),
              //       // ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.stretch,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Text(
              //             'TAKE\n\CARE',
              //             style: TextStyle(
              //               color: Colors.grey[400],
              //               fontSize: 75.0,
              //               fontFamily: 'Roboto',
              //               letterSpacing: 0.2,
              //               height: 0.8,
              //             ),
              //           ),
              //           SizedBox(
              //             height: 24.0,
              //           ),
              //           Text(
              //             'MADE WITH LOVE',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText1
              //                 .copyWith(color: Colors.grey),
              //           ),
              //           Text(
              //             'UMEED APP, SRMIST, Tamil Nadu',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText1
              //                 .copyWith(color: Colors.grey),
              //           ),
              //           SizedBox(
              //             height: 48.0,
              //           ),
              //           Row(
              //             children: <Widget>[
              //               Container(
              //                 height: 1.0,
              //                 width: MediaQuery.of(context).size.width / 4,
              //                 color: Colors.grey,
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
