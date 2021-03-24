import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/authentication/register.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class SignInScreen extends StatefulWidget {
  static String id = "/login";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
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
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            MediaQuery.of(context).size.width * (28 / 375.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in with your email and password  \nor continue socially",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {
                        email = value,
                      },
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Email can't be empty";
                      //   }
                      //   return null;
                      // },
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
                      onChanged: (value) => password = value,
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
                      height: MediaQuery.of(context).size.height * (40 / 812.0),
                    ),
                    Row(
                      children: [
                        Container(),
                        Container(),
                        Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          ),
                          child: Text(
                            "Forgot Password",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        )
                      ],
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
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.popAndPushNamed(context, '/dashboard');
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            print(e.code);
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
                              case 'ERROR_WRONG_PASSWORD':
                                // _showErrorDialog("ERROR_WRONG_PASSWORD");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_WRONG_PASSWORD",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );

                                break;
                              case 'ERROR_USER_NOT_FOUND':
                                // _showErrorDialog("ERROR_USER_NOT_FOUND");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_USER_NOT_FOUND",
                                  confirmBtnText: "Ok",
                                  confirmBtnColor: Colors.blue,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                                break;
                              case 'ERROR_USER_DISABLED':
                                // _showErrorDialog("ERROR_USER_DISABLED");
                                return CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "ERROR_USER_DISABLED",
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
                          "Don’t have an account? ",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  (14 / 375.0)),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          ),
                          child: Text(
                            "Sign Up",
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
