import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/providers/auth_provider.dart';
import 'package:umeed_user_app/screens/authentication/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  String dob = " ";
  bool showSpinner = false;
  String toastMessage = "";
  bool showFloatingToast = false;

  // ignore: missing_return
  Widget _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Authentication Error'),
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

  // ignore: missing_return
  Widget _showSuccessDialog(String successMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformAlertDialog(
            title: Text('Authentication Successful'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(successMessage),
                ],
              ),
            ),
            actions: <Widget>[
              PlatformDialogAction(
                child: Text('Log In'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
              ),
            ],
          );
        });
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _selectDate(AuthProvider authProvider) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        dob = DateFormat("dd-MM-yyyy").format(picked);
        authProvider.dob = dob;
      });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      "Welcome to UMEED",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MediaQuery.of(context).size.width * (25 / 375.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Distress Management Citizen Portal",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {
                        // name = value,
                        authProvider.name = value,
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFFFF7643),
                        // ),
                        hintText: "Enter your name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: SvgPicture.asset(
                            "assets/icons/Mail.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (30 / 812.0)),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {
                        authProvider.email = value,
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFFFF7643),
                        // ),
                        hintText: "Enter your email",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: SvgPicture.asset(
                            "assets/icons/Mail.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (30 / 812.0)),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) => {
                        // password = value,
                        authProvider.password = value,
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFFFF7643),
                        // ),
                        hintText: "Enter your password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 31.0),
                          child: SvgPicture.asset(
                            "assets/icons/Lock.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (30 / 812.0)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) => {
                        // gender = value,
                        authProvider.contact = value,
                      },
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFFFF7643),
                        // ),
                        hintText: "Enter your details",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: SvgPicture.asset(
                            "assets/icons/Mail.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (30 / 812.0)),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          _selectDate(authProvider);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Date of birth",
                        hintText: dob == " " ? "Enter your DOB" : dob,
                        hintStyle: dob == " "
                            ? null
                            : TextStyle(
                                color: Colors.black,
                              ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: SvgPicture.asset(
                            "assets/icons/Mail.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (30 / 812.0)),
                    TextFormField(
                      onChanged: (value) => {
                        // gender = value,
                        authProvider.gender = value,
                      },
                      decoration: InputDecoration(
                        labelText: "Gender",
                        hintText: "Select your gender",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Color(0xFF757575)),
                          gapPadding: 10.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: SvgPicture.asset(
                            "assets/icons/Mail.svg",
                            height: 6.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (40 / 812.0),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * (56 / 812.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color(0xFFFF7643),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: authProvider.email,
                                    password: authProvider.password);

                            authProvider.username =
                                authProvider.name.toLowerCase().split(" ")[0] +
                                    authProvider.dob.substring(0, 2);
                            print(
                                "Generated username is ${authProvider.username}");
                            var user = newUser.user;
                            await FirebaseAuth.instance.currentUser
                                .updateProfile(
                                    displayName: authProvider.username);
                            authProvider.uid = user.uid;
                            authProvider.printDetails();

                            if (newUser != null) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .addUserToDB();
                              setState(() {
                                _showSuccessDialog(
                                    "You are registered successfully.");
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            print(e);
                            switch (e.code) {
                              case 'ERROR_INVALID_EMAIL':
                                // _showErrorDialog("ERROR_INVALID_EMAIL");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_INVALID_EMAIL",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              case 'ERROR_WEAK_PASSWORD':
                                // _showErrorDialog("ERROR_WEAK_PASSWORD");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_WEAK_PASSWORD",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              case 'ERROR_EMAIL_ALREADY_IN_USE':
                                // _showErrorDialog(
                                //     "ERROR_EMAIL_ALREADY_IN_USE");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_EMAIL_ALREADY_IN_USE",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              case 'ERROR_OPERATION_NOT_ALLOWED':
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_OPERATION_NOT_ALLOWED",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              case 'ERROR_INVALID_CREDENTIAL':
                                // _showErrorDialog(
                                //     "ERROR_INVALID_CREDENTIAL");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_INVALID_CREDENTIAL",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              default:
                                // _showErrorDialog(
                                //     "Unknown error has occurred.");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "Authentication error has occurred",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                            }
                          }
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          // onTap: press,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width *
                                    (10 / 375.0)),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width *
                                    (10 / 375.0)),
                            height: MediaQuery.of(context).size.height *
                                (50 / 812.0),
                            width: MediaQuery.of(context).size.width *
                                (40 / 375.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/google-icon.svg",
                              height: 5.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          // onTap: press,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width *
                                    (10 / 375.0)),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width *
                                    (11 / 375.0)),
                            height: MediaQuery.of(context).size.height *
                                (50 / 812.0),
                            width: MediaQuery.of(context).size.width *
                                (40 / 375.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/facebook-2.svg",
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (20 / 812.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  (14 / 375.0)),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  (14 / 375.0),
                              color: Color(0xFFFF7643),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (40 / 812.0)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
