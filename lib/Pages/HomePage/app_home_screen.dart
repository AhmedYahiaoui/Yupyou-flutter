import 'dart:io';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:front_v1/Pages/Dashboard/dashscreen.dart';
import 'package:front_v1/Pages/DevicePage/DeviceScreen.dart';
import 'package:front_v1/Pages/FavoritPage/favoritscreen.dart';
import 'package:front_v1/Pages/ProfilPage/profilescreen.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/bottom_navigation_view/bottom_bar_view.dart';
import 'package:front_v1/bottom_navigation_view/tabIcon_data.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );
  static int i = 0;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[1].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DeviceScreen(animationController: animationController);
    super.initState();
    firebaseCloudMessaging_Listeners();

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
//     DynamicTheme(
//        defaultBrightness: Brightness.dark,
//        data: (brightness) =>  ThemeData(
//          primarySwatch: Colors.indigo,
//          brightness: brightness,
//        ),
//        themedWidgetBuilder: (context, theme) {
//          return MaterialApp(
//            debugShowCheckedModeBanner: false,
//            theme: ThemeData(
//              accentColor: Colors.white70,
////        primarySwatch: Colors.blue,
////        platform: TargetPlatform.iOS,
//            ),
//          );
//        }
//    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {




            if (index == 0 ) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      DashScreen(animationController: animationController);
                });
              });
            }


            else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      DeviceScreen(animationController: animationController);
                });
              });
            }



//
//            if (index == 0 ) {
//              animationController.reverse().then<dynamic>((data) {
//                if (!mounted) {
//                  return;
//                }
//                setState(() {
//                  tabBody =
//                      DashScreen(animationController: animationController);
//                });
//              });
//            }
//
//
//            else if (index == 1) {
//              animationController.reverse().then<dynamic>((data) {
//                if (!mounted) {
//                  return;
//                }
//                setState(() {
//                  tabBody =
//                      DeviceScreen(animationController: animationController);
//                });
//              });
//            }


            else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      FavoritScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ProfileScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print("token ===================>>>>> ");
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

//        snack(message['notification']['body'], 5, Colors.green);


//        i++;


        print(" ++++++++++ onMessage: $message");
        // something else you wanna execute

        await showDialog(
            context: context,builder: (_) =>
            AssetGiffyDialog(
              image: Image.asset('assets/images/map/moving6.gif'),
              title: Text(message['notification']['title'],
                style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600),
              ),

              description: Text(message['notification']['body'],
                textAlign: TextAlign.left,
                style: TextStyle(),
              ),
              onOkButtonPressed: () {
                Navigator.of(context).pop();
              },
              onlyOkButton: true,

            )
        );

//        if(i == 1) {
//
//
//        };



      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }


  void snack(String txt , int dur , Color colr) {
    final snackBar = SnackBar(
      content: Text(txt ),
      duration: Duration(seconds: dur),
//      action: SnackBarAction(
//        label: 'Undo',
//        onPressed: () {
//          Scaffold.of(context).hideCurrentSnackBar();
//        },
//      ),
      backgroundColor: colr,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }


}
