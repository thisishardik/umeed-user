import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/components/calls_and_messaging.dart';
import 'package:umeed_user_app/providers/help_provider.dart';
import 'package:umeed_user_app/components/service_locator.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/info_screen.dart';
import 'package:umeed_user_app/screens/news/news_home.dart';
import 'package:umeed_user_app/screens/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<String> helpline_services = new List<String>();
  List<String> helpline_numbers = new List<String>();
  List<String> helpline_images = new List<String>();
  int index = 2;

  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    helpline_services =
        Provider.of<HelpProvider>(context, listen: false).helpline_services;
    helpline_numbers =
        Provider.of<HelpProvider>(context, listen: false).helpline_numbers;
    helpline_images =
        Provider.of<HelpProvider>(context, listen: false).helpline_images;
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
          'Indian Helpline Services',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.adb),
            color: Colors.black,
            onPressed: () {
              print(helpline_images.length);
              print(helpline_services.length);
              print(helpline_numbers.length);
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(0.0, MediaQuery.of(context).size.height * 0.11),
          child: GFSearchBar(
            searchList: helpline_services,
            searchQueryBuilder: (query, list) {
              return list
                  .where((item) =>
                      item.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            },
            overlaySearchListItemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
            onItemSelected: (item) {
              setState(() {
                print('$item');
              });
            },
          ),
        ),
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
            print("DUHH");
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
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 27,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                leading: Image.asset(
                  "assets/helpline/${helpline_images[index]}",
                  width: MediaQuery.of(context).size.width * 0.13,
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                title: Text(
                  '${helpline_services[index]}',
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('${helpline_numbers[index]}'),
                ),
                trailing: OutlinedButton(
                  onPressed: () {
                    _service.call(helpline_numbers[index]);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    side: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
