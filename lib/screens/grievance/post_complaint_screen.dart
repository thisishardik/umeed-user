import 'dart:io';

import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umeed_user_app/components/bottom_nav_bar.dart';
import 'package:umeed_user_app/helpers/user.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/helpers/complaint.dart';

class PostComplaintScreen extends StatefulWidget {
  String aoc;
  PostComplaintScreen({this.aoc});

  @override
  _PostComplaintScreenState createState() => _PostComplaintScreenState();
}

class _PostComplaintScreenState extends State<PostComplaintScreen> {
  StepState stepState;
  AppUser userData;
  ComplaintProvider complaint;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userData = Provider.of<UserProvider>(context).userData;
    complaint = Provider.of<ComplaintProvider>(context);
  }

  @override
  void initState() {
    super.initState();
    stepState = StepState.indexed;
    currentStep = 0;
  }

  int currentStep;
  int activeStep = 0; // Initial step set to 0.
  int dotCount = 5;
  int flag = 0;

  String landmark;
  String desc;
  Map location;
  String name;

  File imageFile1;
  File imageFile2;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    flag == 1
        ? setState(() {
            imageFile1 = picture;
          })
        : setState(() {
            imageFile2 = picture;
          });

    Navigator.pop(context);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    flag == 1
        ? setState(() {
            imageFile1 = picture;
          })
        : setState(() {
            imageFile2 = picture;
          });
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
                    padding: EdgeInsets.all(8.0),
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

  List<FAStep> get steps => [
        FAStep(
          title: Text("Personal Details"),
          content: Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
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
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
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
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
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
            ],
          ),
          isActive: true,
        ),
        FAStep(
          title: Text("Landmark"),
          content: Column(
            children: [
              SizedBox(height: 5.0),
              TextFormField(
                readOnly: true,
                initialValue: userData.username,
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
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                onChanged: (value) {
                  landmark = value;
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
              SizedBox(height: 15.0),
              TextFormField(
                onChanged: (value) {
                  desc = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
            ],
          ),
          isActive: true,
        ),
        FAStep(
          title: Text("Click Pictures"),
          content: Row(
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
          isActive: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final complaint = Provider.of<ComplaintProvider>(context, listen: false);

    return Scaffold(
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
      ),
      bottomNavigationBar: BottomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              // color: Colors.red,
              child: FAStepper(
                currentStep: currentStep,
                titleHeight: 80,
                steps: steps,
                type: FAStepperType.horizontal,
                titleIconArrange: FAStepperTitleIconArrange.column,
                stepNumberColor: Colors.teal,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                  print("onStepTapped : " + step.toString());
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                  print("onStepCancel : " + currentStep.toString());
                },
                onStepContinue: () {
                  setState(() {
                    // update the variable handling the current step value
                    // going back one step i.e adding 1, until its the length of the step
                    if (currentStep < 3 - 1) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                  // Log function call
                  print("onStepContinue : " + currentStep.toString());
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'These details will be used to register the complaint in the portal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
