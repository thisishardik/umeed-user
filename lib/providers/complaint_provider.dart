import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:umeed_user_app/helpers/complaint.dart';

class ComplaintProvider with ChangeNotifier {
  String id;
  String comp_user_id;
  String landmark;
  String contact;
  String date;
  String desc;
  String area_of_comp;
  String location;
  String name;
  String user_email;
  String imageUrl1;
  String imageUrl2;
  String imageUrl3;
  String imageUrl4;

  /// ToDO Add images File1/2/3/4

  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  String userID;

  List<Complaint> _complaints = new List<Complaint>();

  List<Complaint> get complaints {
    return _complaints;
  }

  void printDetails() {
    print({
      'id': id,
      'comp_user_id': comp_user_id,
      'comp_user_name': name,
      'comp_user_email': user_email,
      'date': date,
      'landmark': landmark,
      'location': location,
      'description': desc,
      'contact': contact,
      'area of concern': area_of_comp,
    }.toString());
  }

  String validate() {
    printDetails();

    if (landmark == null ||
        desc == null ||
        name == null ||
        user_email == null ||
        contact == null ||
        area_of_comp == null) {
      return "Fields must not be empty";
    }
    return "pass";
  }

  Future<List<Complaint>> getAllComplaints() async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      userID = loggedInUser.uid;
      print("USER ID IS : $userID");
    }
    String url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/getallcomplaints";

    final response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> map = jsonDecode(response.body);
    // print(map);
    // final extractedComplaints = map['Items'];
    List<dynamic> extractedComplaints = map['Items'];
    print(extractedComplaints);
    final List<Complaint> complaints = [];

    for (var i = 0; i < extractedComplaints.length; i++) {
      print("EXTRACTED ELEMENTS AT I POS ${extractedComplaints[i]}");
      complaints.add(
        Complaint(
          id: extractedComplaints[i]['id'],
          comp_user_id: extractedComplaints[i]['comp_user_id'],
          user_email: extractedComplaints[i]['comp_user_email'],
          landmark: extractedComplaints[i]['comp_user_address'],
          contact: extractedComplaints[i]['contact'],
          date: extractedComplaints[i]['date'],
          desc: extractedComplaints[i]['description'],
          location: extractedComplaints[i]['location'],
          name: extractedComplaints[i]['comp_user_name'],
          area_of_comp: extractedComplaints[i]['area_of_comp'],
        ),
      );
    }
    // extractedComplaints.forEach((element) {
    //   complaints.add(
    //     Complaint(
    //         id: element['id'],
    //         address: element['address'],
    //         contact: element['contact'],
    //         date: element['date'],
    //         desc: element['description'],
    //         location: element['location'],
    //         name: element['name']),
    //   );
    // });
    notifyListeners();
    _complaints = complaints;
    print("THIS IS COMPLAINTS LIST $_complaints");
    return _complaints;
  }

  postComplaintToDB() async {
    const url =
        "https://xk01e5qt90.execute-api.us-east-1.amazonaws.com/v1/user/postcomplaint";
    Map<String, String> headers = {"Content-type": "application/json"};

    String json =
        '{"id":"$id","comp_user_id":"$comp_user_id","comp_user_name":"$name","comp_user_email":"$user_email","date":"$date","landmark":"$landmark","location":"$location","description":"$desc","contact":"$contact","area_of_comp":"$area_of_comp","imageUrl1":"$imageUrl1","imageUrl2":"$imageUrl2","imageUrl3":"$imageUrl3","imageUrl4":"$imageUrl4"}';
    // print("THIS IS THE JSON FILE FOR POST API $json");
    final response = await http.post(url, body: json, headers: headers);
    if (response.statusCode == 200) {
      // print("RESPONSE IS $response");
      print("POSTING COMPLAINT STATUS CODE ${response.statusCode}");
      print("POSTING COMPLAINT RESPONSE BODY ${response.body}");
      return response.statusCode;
    }
    print("POSTING COMPLAINT STATUS CODE ${response.statusCode}");
    print("POSTING COMPLAINT RESPONSE BODY ${response.body}");
    notifyListeners();
  }

// void postUserData(File imageFile, String id, String name, String email,
//     String phone, String token) async {
//   var url = "https://bodyappdefault.herokuapp.com/user/profile";
//
//   var request = new http.MultipartRequest("PUT", Uri.parse(url));
//   request.headers.addAll(
//       {"Accept": "application/json", "Authorization": "Bearer " + token});
//   request.fields['user_id'] = id;
//   request.fields['user_name'] = name;
//   request.fields['user_email'] = email;
//   request.fields['user_phone'] = phone;
//   request.files.add(new http.MultipartFile.fromBytes(
//       'file', await File.fromUri(Uri.parse(imageFile.path)).readAsBytes(),
//       contentType: MediaType(
//           'image', 'jpeg'))); // var data = new Map<String, dynamic>();
//   // data['user_id'] = id;
//   // data['user_name'] = name;
//   // data['user_email'] = email;
//   // data['user_phone'] = phone;
//   // var data = {
//   //   "user_id": id,
//   //   "user_name": name,
//   //   "user_email": email,
//   //   "user_phone": phone
//   // };
//
//   // final response = await http.put(url,
//   //     headers: {HttpHeaders.authorizationHeader: "Basic $token"}, body: data);
//   final response = await request.send();
//   print("edit profile" + response.statusCode.toString());
//
//   // const url1 = "https://bodyappdefault.herokuapp.com/user/profile";
//
//   // final response1 = await http
//   //     .get(url1, headers: {HttpHeaders.authorizationHeader: "Basic $token"});
//
//   // Map<String, dynamic> map = jsonDecode(response1.body);
//   // final extractedUserData = map['data'];
//   // print(extractedUserData);
//   getUserData(token);
//   notifyListeners();
// }

}
