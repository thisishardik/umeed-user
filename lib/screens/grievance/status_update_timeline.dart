import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:umeed_user_app/components/calls_and_messaging.dart';
import 'package:umeed_user_app/components/service_locator.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/news/news_home.dart';
import 'package:umeed_user_app/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusUpdateTimeline extends StatefulWidget {
  final String id;
  StatusUpdateTimeline({this.id});

  @override
  _StatusUpdateTimelineState createState() => _StatusUpdateTimelineState();
}

class _StatusUpdateTimelineState extends State<StatusUpdateTimeline> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  String myEmail = "technical.hardik29@gmail.com";

  int index = 0;

  List<String> status = ['POSTED', 'ATTENDED', 'Reaching You Out', 'CLOSED'];
  List<String> statusMessage1 = [
    'Your complaint has been posted on UMEED concerning Health and Sanitation.',
    'Please wait until your complaint is assigned to and attended by our representative.',
  ];
  List<String> statusMessage2 = [
    'Your complaint has been viewed and attended at our end.',
    'We are looking into the problem and working towards solving it as soon as possible.',
  ];
  List<String> statusMessage3 = [
    'Our representative will get in touch with you soon.',
    "Please make sure you don't miss the call. The personnel will try to connect with you twice in case of any problem.",
  ];
  List<String> statusMessage4 = [
    'We hope your grievance was tackled and solved effectively by us.',
    'Your complaint has been closed at our end. In case of any discrepancies, please contact us or post a fresh complaint.'
  ];

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff0c18fb),
          child: Icon(Icons.email_outlined),
          tooltip: "Reach out to us",
          onPressed: () => _service.sendEmail(myEmail),
        ),
        body: FutureBuilder(
          future: fetchUserComplaintByID(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var complaintData = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.98,
                      child: Card(
                        margin: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Complaint ID',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11.0,
                                        ),
                                      ),
                                      Text(
                                        '${complaintData['id']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    '${complaintData['date'].toString().substring(0, 10)}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 1.0),
                            DefaultTextStyle(
                              style: TextStyle(
                                color: Color(0xff9b9b9b),
                                fontSize: 12.5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 40.0, horizontal: 10.0),
                                child: FixedTimeline.tileBuilder(
                                  theme: TimelineThemeData(
                                    nodePosition: 0,
                                    color: Color(0xff989898),
                                    indicatorTheme: IndicatorThemeData(
                                      position: 0,
                                      size: 20.0,
                                    ),
                                    connectorTheme: ConnectorThemeData(
                                      thickness: 2.5,
                                    ),
                                  ),
                                  builder: TimelineTileBuilder.connected(
                                    connectionDirection:
                                        ConnectionDirection.before,
                                    itemCount: 4,
                                    contentsBuilder: (_, index) {
                                      // if (status[index] == 'POSTED') return null;

                                      return Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              status[index],
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style
                                                      .copyWith(
                                                        color: complaintData[
                                                                    'status'] !=
                                                                status[index]
                                                            ? Colors.grey
                                                            : Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight: complaintData[
                                                                    'status'] !=
                                                                status[index]
                                                            ? FontWeight.w400
                                                            : FontWeight.w600,
                                                      ),
                                            ),
                                            _InnerTimeline(
                                              messages: complaintData[
                                                          'status'] ==
                                                      status[index]
                                                  ? status[index] == 'POSTED'
                                                      ? [
                                                          'Your complaint has been posted on UMEED on ${complaintData['date'].toString().substring(0, 10)} concerning ${complaintData['area_of_comp']}.',
                                                          'Please wait until your complaint is assigned to and attended by our representative.'
                                                        ]
                                                      : status[index] ==
                                                              'ATTENDED'
                                                          ? statusMessage2
                                                          : status[index] ==
                                                                  'Reaching You Out'
                                                              ? statusMessage3
                                                              : statusMessage4
                                                  : [
                                                      "No updates. Please check again later."
                                                    ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    indicatorBuilder: (_, index) {
                                      if (status[index] == 'POSTED') {
                                        return DotIndicator(
                                          size: 22.5,
                                          color: complaintData['status'] ==
                                                  'POSTED'
                                              ? Color(0xff66c97f)
                                              : Colors.grey,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        );
                                      } else if (status[index] == 'ATTENDED') {
                                        return DotIndicator(
                                          size: 22.5,
                                          color: complaintData['status'] ==
                                                  'ATTENDED'
                                              ? Color(0xFFf2e233)
                                              : Colors.grey,
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        );
                                      } else if (status[index] ==
                                          'Reaching You Out') {
                                        return DotIndicator(
                                          size: 22.5,
                                          color: complaintData['status'] ==
                                                  'Reaching You Out'
                                              ? Color(0xff0c18fb)
                                              : Colors.grey,
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                            size: 13.0,
                                          ),
                                        );
                                      } else {
                                        return DotIndicator(
                                          size: 22.5,
                                          color: complaintData['status'] ==
                                                  'CLOSED'
                                              ? Colors.red
                                              : Colors.grey,
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        );
                                      }
                                    },
                                    connectorBuilder: (context, index, ___) =>
                                        SolidLineConnector(
                                      color: status[index] == 'POSTED'
                                          ? null
                                          : status[index] == 'ATTENDED'
                                              ? Colors.yellow
                                              : status[index] ==
                                                      'Reaching You Out'
                                                  ? Colors.blue
                                                  : Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(height: 1.0),
                            // Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: _OnTimeBar(driver: data.driverInfo),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
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

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    @required this.messages,
  });

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.0,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
              !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                messages[index - 1].toString(),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: messages.length + 2,
        ),
      ),
    );
  }
}

// class _DeliveryProcesses extends StatelessWidget {
//   const _DeliveryProcesses({Key key, @required this.processes})
//       : assert(processes != null),
//         super(key: key);
//
//   final List<_DeliveryProcess> processes;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//       style: TextStyle(
//         color: Color(0xff9b9b9b),
//         fontSize: 12.5,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: FixedTimeline.tileBuilder(
//           theme: TimelineThemeData(
//             nodePosition: 0,
//             color: Color(0xff989898),
//             indicatorTheme: IndicatorThemeData(
//               position: 0,
//               size: 20.0,
//             ),
//             connectorTheme: ConnectorThemeData(
//               thickness: 2.5,
//             ),
//           ),
//           builder: TimelineTileBuilder.connected(
//             connectionDirection: ConnectionDirection.before,
//             itemCount: processes.length,
//             contentsBuilder: (_, index) {
//               if (processes[index].isCompleted) return null;
//
//               return Padding(
//                 padding: EdgeInsets.only(left: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       processes[index].name,
//                       style: DefaultTextStyle.of(context).style.copyWith(
//                             fontSize: 18.0,
//                           ),
//                     ),
//                     _InnerTimeline(messages: processes[index].messages),
//                   ],
//                 ),
//               );
//             },
//             indicatorBuilder: (_, index) {
//               if (processes[index].isCompleted) {
//                 return DotIndicator(
//                   color: Color(0xff66c97f),
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 12.0,
//                   ),
//                 );
//               } else {
//                 return OutlinedDotIndicator(
//                   borderWidth: 2.5,
//                 );
//               }
//             },
//             connectorBuilder: (_, index, ___) => SolidLineConnector(
//               color: processes[index].isCompleted ? Color(0xff66c97f) : null,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _OnTimeBar extends StatelessWidget {
//   const _OnTimeBar({Key key, @required this.driver})
//       : assert(driver != null),
//         super(key: key);
//
//   final _DriverInfo driver;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Builder(
//           builder: (context) => MaterialButton(
//             onPressed: () {
//               Scaffold.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('On-time!'),
//                 ),
//               );
//             },
//             elevation: 0,
//             shape: StadiumBorder(),
//             color: Color(0xff66c97f),
//             textColor: Colors.white,
//             child: Text('On-time'),
//           ),
//         ),
//         Spacer(),
//         Text(
//           'Driver\n${driver.name}',
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(width: 12.0),
//         Container(
//           width: 40.0,
//           height: 40.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               fit: BoxFit.fitWidth,
//               image: NetworkImage(
//                 driver.thumbnailUrl,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
