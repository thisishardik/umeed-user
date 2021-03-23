import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/announcements.dart';
import 'package:umeed_user_app/screens/grievance/complaint_detail.dart';
import 'package:umeed_user_app/screens/grievance/status_update_timeline.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/news/news_home.dart';
import 'package:umeed_user_app/screens/profile_screen.dart';

class CheckStatusScreen extends StatefulWidget {
  @override
  _CheckStatusScreenState createState() => _CheckStatusScreenState();
}

class _CheckStatusScreenState extends State<CheckStatusScreen> {
  AppUser userData;
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userData = Provider.of<UserProvider>(context, listen: false).userData;
    // Provider.of<AuthProvider>(context, listen: false).printDetails();
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
          onPressed: () => Navigator.popAndPushNamed(context, '/dashboard'),
        ),
        title: Text(
          'Grievance Status Update',
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
            Navigator.push(
              context,
              PageTransition(
                child: ProfileScreen(),
                type: PageTransitionType.fade,
              ),
            );
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
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<ComplaintProvider>(context).getAllComplaints(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var complaintData = snapshot.data[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new AssetImage(
                                          userData.gender == 'Male' ||
                                                  userData.gender == 'male'
                                              ? 'assets/images/male_pic.jpg'
                                              : 'assets/images/female_pic.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${userData.username}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "${complaintData.date.toString().substring(0, 19)}",
                                        style: TextStyle(
                                          fontSize: 11.5,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StatusUpdateTimeline(
                                        id: complaintData.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Check Status',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.40,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                          items: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: complaintData.imageUrl1 != null
                                      ? NetworkImage(complaintData.imageUrl1)
                                      : AssetImage(
                                          "assets/images/no_image.jpg"),
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
                                  image: complaintData.imageUrl2 != null
                                      ? NetworkImage(complaintData.imageUrl2)
                                      : AssetImage(
                                          "assets/images/no_image.jpg"),
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
                                  image: complaintData.imageUrl3 != null
                                      ? NetworkImage(complaintData.imageUrl3)
                                      : AssetImage(
                                          "assets/images/no_image.jpg"),
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
                                  image: complaintData.imageUrl4 != null
                                      ? NetworkImage(complaintData.imageUrl4)
                                      : AssetImage(
                                          "assets/images/no_image.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "${complaintData.area_of_comp}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "${complaintData.landmark}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
