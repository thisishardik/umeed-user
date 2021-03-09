import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/async/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/choice.dart';
import 'package:umeed_user_app/helpers/complaint.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/location_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/screens/grievance/success_screen.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class PostGrievanceScreen extends StatefulWidget {
  String aoc;
  PostGrievanceScreen({this.aoc});

  @override
  _PostGrievanceScreenState createState() => _PostGrievanceScreenState();
}

class _PostGrievanceScreenState extends State<PostGrievanceScreen> {
  StepState stepState;
  AppUser userData;
  Location location = Location();

  List<Address> myLocation;

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  fetchMeTheCoordinates() async {
    myLocation = await location.getMyCurrentLocation();
    print("My location is ${myLocation.first.addressLine}");
  }

  Widget _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Error has occurred'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
            ),
            actions: <Widget>[
              PlatformDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              PlatformDialogAction(
                child: Text('Ok'),
                actionType: ActionType.Preferred,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userData = Provider.of<UserProvider>(context).userData;
  }

  @override
  void initState() {
    super.initState();
    print(GeolocatorPlatform.instance.checkPermission());
    fetchMeTheCoordinates();
  }

  @override
  void dispose() {
    super.dispose();
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    imageFile4 = null;
  }

  int flag = 0;

  String landmark;
  String desc;
  String name;

  File imageFile1;
  File imageFile2;
  File imageFile3;
  File imageFile4;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (flag == 1) {
      setState(() {
        imageFile1 = picture;
      });
    }
    if (flag == 2) {
      setState(() {
        imageFile2 = picture;
      });
    }
    if (flag == 3) {
      setState(() {
        imageFile3 = picture;
      });
    }
    if (flag == 4) {
      setState(() {
        imageFile4 = picture;
      });
    }

    Navigator.pop(context);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (flag == 1) {
      setState(() {
        imageFile1 = picture;
      });
    }
    if (flag == 2) {
      setState(() {
        imageFile2 = picture;
      });
    }
    if (flag == 3) {
      setState(() {
        imageFile3 = picture;
      });
    }
    if (flag == 4) {
      setState(() {
        imageFile4 = picture;
      });
    }
    Navigator.pop(context);
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Upload image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: () => _openCamera(context),
                    child: Text('Camera'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    onTap: () => _openGallery(context),
                    child: Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Choice> choices = <Choice>[
    Choice(title: 'Your Details', icon: Icons.account_circle_outlined),
    Choice(title: 'Landmark', icon: Icons.assignment_outlined),
    Choice(title: 'Upload', icon: AntDesign.upload),
  ];

  @override
  Widget build(BuildContext context) {
    final complaintProvider =
        Provider.of<ComplaintProvider>(context, listen: false);
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'New Complaint',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.teal,
              labelColor: Colors.black,
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: userData.name,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: userData.email,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: userData.contact,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Contact",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: widget.aoc,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Area of Concern",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        complaintProvider.landmark = value;
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Enter the landmark",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        complaintProvider.desc = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 13,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Describe your problem",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = 1;
                          });
                          showChoiceDialog(context);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 180.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: imageFile1 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        height: 200,
                                      )
                                    : Image.file(
                                        imageFile1,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = 2;
                          });
                          showChoiceDialog(context);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 180.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: imageFile2 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        height: 200,
                                      )
                                    : Image.file(
                                        imageFile2,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = 3;
                          });
                          showChoiceDialog(context);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 180.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: imageFile3 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        height: 200,
                                      )
                                    : Image.file(
                                        imageFile3,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = 4;
                          });
                          showChoiceDialog(context);
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 180.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.teal,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: imageFile4 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        height: 200,
                                      )
                                    : Image.file(
                                        imageFile4,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  RoundedLoadingButton(
                    child: Text(
                      'Post Complaint',
                      style: TextStyle(color: Colors.white),
                    ),
                    controller: _btnController,
                    onPressed: () async {
                      String complaintID = await nanoid(20);
                      complaintProvider.name = userData.name;
                      complaintProvider.user_email = userData.email;
                      complaintProvider.contact = userData.contact;
                      complaintProvider.comp_user_id = userData.uid;
                      complaintProvider.area_of_comp = widget.aoc;
                      complaintProvider.date = DateTime.now().toString();
                      complaintProvider.id = complaintID;
                      complaintProvider.location = myLocation.first.addressLine;

                      final result =
                          Provider.of<ComplaintProvider>(context, listen: false)
                              .validate();
                      print("RESULT IS $result");
                      if (result != 'pass') {
                        _showErrorDialog(result);
                        _btnController.reset();
                      } else {
                        Provider.of<ComplaintProvider>(context, listen: false)
                            .postComplaintToDB();
                        _btnController.success();

                        /// ToDo Implement validation of all fields and call both apis for data and images
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(),
                              ));
                        });
                      }
                    },
                    width: 250.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
