import 'package:flutter/material.dart';
import 'package:umeed_user_app/providers/announcements_provider.dart';
import 'package:umeed_user_app/providers/bottom_navigation_provider.dart';
import 'package:umeed_user_app/providers/complaint_provider.dart';
import 'package:umeed_user_app/providers/dashboard_provider.dart';
import 'package:umeed_user_app/providers/user_provider.dart';
import 'package:umeed_user_app/providers/auth_provider.dart';
import 'package:umeed_user_app/screens/authentication/login.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:umeed_user_app/screens/splash.dart';
import 'package:umeed_user_app/providers/help_provider.dart';
import 'package:umeed_user_app/components/service_locator.dart';

/// ToDo  PUT BACK BUTTON INTERCEPTORS EVERYWHERE.

void main() async {
  setupLocator();
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
          value: BottomNavigationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DashboardProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ComplaintProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HelpProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AnnouncementsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HelpProvider(),
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
