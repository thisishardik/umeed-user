import 'dart:async';
import 'package:geocoder/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/auth_provider.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/grievance/area_of_concern.dart';

class Dashboard extends StatefulWidget {
  static String id = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AppUser userData;
  AuthProvider authProvider;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static Future<LocationPermission> checkLocationPermission() {
    GeolocatorPlatform.instance.requestPermission();
  }

  String uid = "";

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userData = Provider.of<UserProvider>(context, listen: false).userData;
    Provider.of<AuthProvider>(context, listen: false).printDetails();
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
              onPressed: () {},
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
                        size: 22.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Announcements",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.assignment_outlined,
                        color: Colors.blueGrey,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Grievance History",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.adb,
                        color: Colors.blueGrey,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Help",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        AntDesign.infocirlceo,
                        color: Colors.blueGrey,
                        size: 22.0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "About",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        AntDesign.logout,
                        color: Colors.blueGrey,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 1.0,
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
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<UserProvider>(context).getUserProfileData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.075,
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
                                            MediaQuery.of(context).size.width *
                                                0.5,
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
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                ),
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
                              minWidth: MediaQuery.of(context).size.width,
                              minHeight: 120.0,
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
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      child: Text(
                                        'WHERE I AM',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
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
                                Image.asset(
                                  "assets/images/grief.png",
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                ),
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
                              minWidth: MediaQuery.of(context).size.width,
                              minHeight: 120.0,
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
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      child: Text(
                                        'NEAR ME',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      'Find out nearby police stations and\n helpline centers.',
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
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
