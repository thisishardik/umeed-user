import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/helpers/complaint.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/news/news_home.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int index = 4;
  AppUser userData;

  int postedComplaints;
  int attendedComplaints;
  int closedComplaints;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postedComplaints = 0;
    attendedComplaints = 0;
    closedComplaints = 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userData = Provider.of<UserProvider>(context, listen: false).userData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            'Profile',
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
            if (index == 4) {
              print("DUHH!!");
            }
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
        backgroundColor: Colors.grey.shade300,
        body: FutureBuilder(
            future: Provider.of<ComplaintProvider>(context).getAllComplaints(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // snapshot.data['Items'].forEach((complaint) => {
                //     if(complaint['status'] == 'POSTED'){
                //         postedComplaints = postedComplaints + 1;
                //     } else if(complaint['status'] == 'ATTENDED'){
                //         attendedComplaints = postedComplaints + 1;
                //       } else (complaint['status'] == 'CLOSED'){
                //           closedComplaints = postedComplaints + 1;
                //         }
                // });

                // for (int i = 0; i < 3; i = i + 1) {
                //   if (snapshot.data['Items'][i]['status'] == 'POSTED') {
                //     postedComplaints = postedComplaints + 1;
                //   } else if (snapshot.data['Items'][i]['status'] ==
                //       'ATTENDED') {
                //     attendedComplaints = attendedComplaints + 1;
                //   } else {
                //     closedComplaints = closedComplaints + 1;
                //   }
                //   // postedComplaints = snapshot.data['Items']
                //   //     .where(snapshot.data['Items'][i]['status'] == 'POSTED');
                //   // attendedComplaints = snapshot.data['Items']
                //   //     .where(snapshot.data['Items'][i]['status'] == 'ATTENDED');
                //   // closedComplaints = snapshot.data['Items']
                //   //     .where(snapshot.data['Items'][i]['status'] == 'CLOSED');
                // }
                return SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(
                            "assets/images/logo.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 95),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${userData.username}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title,
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text("${userData.email}"),
                                              //You can add Subtitle here
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("${postedComplaints}"),
                                                Text(
                                                  "POSTED",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("${attendedComplaints}"),
                                                Text(
                                                  "ATTENDED",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text("${closedComplaints}"),
                                                Text(
                                                  "CLOSED",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/logo.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text("User Information"),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("User ID"),
                                    subtitle: Text("${userData.uid}"),
                                    leading:
                                        Icon(Icons.account_circle_outlined),
                                  ),
                                  ListTile(
                                    title: Text("Name"),
                                    subtitle: Text("${userData.name}"),
                                    leading: Icon(Icons.account_box),
                                  ),
                                  ListTile(
                                    title: Text("Email"),
                                    subtitle: Text("${userData.email}"),
                                    leading: Icon(Icons.email_outlined),
                                  ),
                                  ListTile(
                                    title: Text("Phone Number"),
                                    subtitle: Text("${userData.contact}"),
                                    leading: Icon(Icons.phone),
                                  ),
                                  ListTile(
                                    title: Text("Date of Birth"),
                                    subtitle: Text("${userData.dob}"),
                                    leading: Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
