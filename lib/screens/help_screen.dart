import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
            'Helpline Service',
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
          bottom: PreferredSize(
            preferredSize: Size(0.0, MediaQuery.of(context).size.height * 0.11),
            child: GFSearchBar(
              searchList: ["1, 2, 3"],
              searchQueryBuilder: (query, list) {
                return list
                    .where((item) =>
                        item.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              overlaySearchListItemBuilder: (item) {
                return Container(
                  padding: const EdgeInsets.all(5),
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
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ));
  }
}
