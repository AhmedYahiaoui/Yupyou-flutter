import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_v1/Pages/HomePage/app_home_screen.dart';
import 'package:front_v1/SplashScreen/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

        return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
//      theme: ThemeData(
//          accentColor: Colors.white70,
////        primarySwatch: Colors.blue,
////        platform: TargetPlatform.iOS,
//      ),

//          theme: ThemeData.dark(),
    );





  }




}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    super.initState();
//    firebaseCloudMessaging_Listeners();
    checkLoginStatus();
    checkNOTLoginStatus();
  }


//
//
//
//  checkLoginStatus() async {
//    sharedPreferences = await SharedPreferences.getInstance();
//    if (sharedPreferences.getString("token") != null) {
//      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
//          (BuildContext context) => AppHomeScreen()),
//              (Route<dynamic> route) => false);
//    }
//  }




  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {



      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          (BuildContext context) => SplashScreen(
            'assets/splashscreen.flr',
//        FitnessAppHomeScreen(),
            AppHomeScreen(),
            startAnimation: 'intro',
            backgroundColor: Colors.white,)),
              (Route<dynamic> route) => false);
    }
  }

  checkNOTLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          (BuildContext context) => SplashScreen(
            'assets/splashscreen.flr',
//        FitnessAppHomeScreen(),
            OnboardingScreen(),
            startAnimation: 'intro',
            backgroundColor: Colors.white,)), (
          Route<dynamic> route) => false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return  DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (brightness) =>  ThemeData(
          primarySwatch: Colors.indigo,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            home: SplashScreen(
              'assets/splashscreen.flr',
//        FitnessAppHomeScreen(),
              OnboardingScreen(),
              startAnimation: 'intro',
              backgroundColor: Colors.white,
            ),
          );
        }
    );
  }


//  void firebaseCloudMessaging_Listeners() {
//    if (Platform.isIOS) iOS_Permission();
//
//    _firebaseMessaging.getToken().then((token){
//      print("token ===================>>>>> ");
//      print(token);
//    });
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//
//
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//      },
//    );
//  }
//
//  void iOS_Permission() {
//    _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true)
//    );
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings)
//    {
//      print("Settings registered: $settings");
//    });
//  }
//
//
//  void snack(String txt , int dur , Color colr) {
//    final snackBar = SnackBar(
//      content: Text(txt ),
//      duration: Duration(seconds: dur),
////      action: SnackBarAction(
////        label: 'Undo',
////        onPressed: () {
////          Scaffold.of(context).hideCurrentSnackBar();
////        },
////      ),
//      backgroundColor: colr,
//    );
//    Scaffold.of(context).showSnackBar(snackBar);
//  }


}


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

