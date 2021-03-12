import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:umeed_user_app/helpers/announcement.dart';
import 'package:umeed_user_app/helpers/complaint.dart';

class AnnouncementsProvider with ChangeNotifier {
  List<Announcement> _announcements = new List<Announcement>();

  List<Announcement> get announcements {
    return _announcements;
  }

  Future<List<Announcement>> getAnnouncements() async {
    String url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/announcements";

    final response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> map = jsonDecode(response.body);

    List<dynamic> extractedAnnouncements = map['Items'];
    final List<Announcement> announcements = [];

    for (var i = 0; i < extractedAnnouncements.length; i++) {
      print("EXTRACTED ELEMENTS AT I POS ${extractedAnnouncements[i]}");
      announcements.add(
        Announcement(
          title: extractedAnnouncements[i]['title'],
          announcement: extractedAnnouncements[i]['announcement'],
        ),
      );
    }
    notifyListeners();
    _announcements = announcements;
    print("THIS IS ANNOUNCEMENTS LIST $_announcements");
    return _announcements;
  }
}
