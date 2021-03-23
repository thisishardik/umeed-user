import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/info_screen.dart';

class ComplaintDetailScreen extends StatefulWidget {
  final String id;
  ComplaintDetailScreen({@required this.id});

  @override
  _ComplaintDetailScreenState createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  AppUser userData;
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userData = Provider.of<UserProvider>(context, listen: false).userData;
    // authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Your Complaint',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.adb),
            color: Colors.black,
            onPressed: () {
              print(DateTime.now());
            },
          )
        ],
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
                child: InfoScreen(),
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
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchUserComplaintByID(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print("SNAPSHOT DATA : ${snapshot.data}");
              var userComplaintData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Complaint ID",
                            ),
                            Text(
                              "${userComplaintData['id']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                            ),
                            Text(
                              "${userComplaintData['comp_user_name']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone Number",
                            ),
                            Text(
                              "${userComplaintData['contact']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                            ),
                            Text(
                              "${userComplaintData['comp_user_email']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Posted On",
                            ),
                            Text(
                              "${userComplaintData['date']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Landmark",
                            ),
                            Text(
                              "${userComplaintData['landmark']}",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Description",
                            ),
                            Text(
                              "${userComplaintData['description']}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              print("SNAPSHOT DATA : ${snapshot.data}");
              // print("COMPLAINT ID FOR API IS : ${widget.id}");
              return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<Map> fetchUserComplaintByID(String id) async {
    String url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/complaintid/$id";

    http.Response response = await http.get(url);
    print(response.statusCode);
    return json.decode(response.body);
  }
}
