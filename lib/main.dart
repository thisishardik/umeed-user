import 'package:flutter/material.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/providers/auth_provider.dart';
import 'package:umeed_user_app/screens/authentication/login.dart';
import 'package:umeed_user_app/screens/authentication/register.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:umeed_user_app/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ComplaintProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 10,
            ),
          ),
        ),
        routes: {
          SignInScreen.id: (context) => SignInScreen(),
          Dashboard.id: (context) => Dashboard(),
        },
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
