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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Personal Information',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            buildRowPaddingData(
                                "Username", "${userData.username}"),
                            buildRowPaddingData("Name", "${userData.name}"),
                            buildRowPaddingData("Email", "${userData.email}"),
                            buildRowPaddingData(
                                "Phone Number", "${userData.contact}"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Complaint Details',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            buildRowPaddingData(
                                "Complaint ID", "${userComplaintData['id']}"),
                            buildRowPaddingData(
                                "Status", "${userComplaintData['status']}"),
                            buildRowPaddingData("Posted On",
                                "${userComplaintData['date'].toString().substring(0, 19)}"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Posted From",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 32.0),
                                      child: Text(
                                        "${userComplaintData['location']}",
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildRowPaddingData("Area of Concern",
                                "${userComplaintData['area_of_comp']}"),
                            buildRowPaddingData(
                                "Landmark", "${userComplaintData['landmark']}"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Grievance Details',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text("${userComplaintData['description']}"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Pictures',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.40,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: userComplaintData['imageUrl1'] != null
                                  ? NetworkImage(userComplaintData['imageUrl1'])
                                  : AssetImage("assets/images/no_image.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: userComplaintData['imageUrl2'] != null
                                  ? NetworkImage(userComplaintData['imageUrl2'])
                                  : AssetImage("assets/images/no_image.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: userComplaintData['imageUrl3'] != null
                                  ? NetworkImage(userComplaintData['imageUrl3'])
                                  : AssetImage("assets/images/no_image.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: userComplaintData['imageUrl4'] != null
                                  ? NetworkImage(userComplaintData['imageUrl4'])
                                  : AssetImage("assets/images/no_image.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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

  Widget buildRowPaddingData(String titleText, String infoText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$titleText",
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Text(
            "$infoText",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
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
