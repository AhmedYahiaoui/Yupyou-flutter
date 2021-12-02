import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:front_v1/Pages/Dashboard/widgets/title_view.dart';
import 'package:front_v1/Pages/DevicePage/testFile.dart';
import 'package:front_v1/Pages/DevicePage/widgets/category_view.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/title_view_head.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/two_side_rounded_button.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:io';

//DatabaseHelper databaseHelper = new DatabaseHelper();
DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<DeviceScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  int _selectedPage = 0;
  Animation<double> topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {


    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));


    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    setState(() {
      MyApp();
    });
    super.initState();
//    firebaseCloudMessaging_Listeners();

  }

  void addAllListData() {
    const int count = 5;

    listViews.add(
      TitleViewHead(
        titleTxt: 'What you \nhave ',
        titleTxt2: 'For now ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );




//    listViews.add(
//      categoryListView(
//        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 5, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );


    listViews.add(MyApp());
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  10,
              bottom: 50 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Devices',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Image(
                                height: 40,
                                width: 40,
                                image: AssetImage(
                                  'assets/images/userr.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
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
////        snack(message['notification']['body'], 5, Colors.green);
//
//
//        await showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            content: ListTile(
//              title: Text(message['notification']['title']),
//              subtitle: Text(message['notification']['body']),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: () => Navigator.of(context).pop(),
//              ),
//            ],
//          ),
//        );
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 2, bottom: 18),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child:FutureBuilder(
//                future: databaseHelper.getData(),
                future: databaseHelper2.AllDeviceByUser(),
                builder: (context,snapshot) {
                  if (snapshot.hasError)
                  {
                    print(snapshot.error);
                    print("mochkla lenaa *");
                  }
                  return snapshot.hasData
                      ?  ItemList(list: snapshot.data)
                      :  Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.nearlyDarkGeen
                    ),
                  ),
                  );
                }),
      ),
    );
  }
}

class ItemList extends StatelessWidget{
  List list;
  ItemList({this.list});

  ScrollController _controller = new ScrollController();


  @override
    Widget build(BuildContext context) {
      return ListView.builder(
          itemCount: list == null ? 0 : list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            String imagechoice() {
              var grade = list[i]['category'];
              switch (grade) {
                case "humun":
                  {
                    return 'assets/images/onedevice/plant1.png';
                  }
                  break;
                case "animal":
                  {
                    return 'assets/images/onedevice/plant0.png';
                  }
                  break;
                case "car":
                  {
                    return 'assets/images/onedevice/plant2.png';
                  }
                  break;
                case "object":
                  {
                    return 'assets/images/onedevice/obj.png';
                  }
                  break;
              }
            }
            IconData iconchoice() {
              var grade = list[i]['category'];
              switch (grade) {
                case "humains":
                  {
                    return Icons.person_outline;
                  }
                  break;
                case "animals":
                  {
                    return Icons.adb;
                  }
                  break;
                case "cars":
                  {
                    return Icons.local_shipping;
                  }
                  break;
                case "objects":
                  {
                    return Icons.child_friendly;
                  }
                  break;
              }
            }
            IconData likechoice() {
              var grade = list[i]['favorit'];
              switch (grade) {
                case true:
                  {
                    return Icons.favorite;
                  }
                  break;
                case false:
                  {
                    return Icons.favorite_border;
                  }
                  break;
              }
            }


//            DateTime t = DateTime.parse(list[i]['date_published'].toString());



            String t = list[i]['date_published'];
            var long2 = int.tryParse(t);
            var date = DateTime.fromMillisecondsSinceEpoch(long2);
//            var formattedDate = DateFormat.yMMMMEEEEd().format(date);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 2),

              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.7,

              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
//                      height: 221,
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ),
                  Image.asset(
                    imagechoice(),
//                    width: 150,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Positioned(
//                    top: 60,
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.width / 3.2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            'Device name is',
                            style: GoogleFonts.exo2(
                              color: Color(0xFF8F8F8F),
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            list[i]['title'],
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(
//                              left: 24
                              left:MediaQuery.of(context).size.width * 0.08
                          ),
                          child: Text(
                            'Created at',
                            style: GoogleFonts.exo2(
                              color: Color(0xFF8F8F8F),
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),





                        Padding(
                          padding: EdgeInsets.only(
//                              left: 24
                              left: MediaQuery.of(context).size.width * 0.09

                          ),
                          child: Text(
                            DateFormat.yMMMMEEEEd().format(date).toString(),
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),


                  Positioned(
//                    top: 160,
                    top: MediaQuery.of(context).size.height * 0.195,

                    child: Container(
                      height: 85,
//                      width: 350,

//                      height: MediaQuery.of(context).size.height * 0.15,
//                      width: 350,
                      width: MediaQuery.of(context).size.width * 0.852,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
//                                  width: 110,
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(3, 7),
                                          blurRadius: 20,
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          likechoice(),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TwoSideRoundedButton(
                                  text: "Read more ..",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DeviceShowDetails(
                                              list: list,
                                              index: i,
                                              slugg: list[i]['_id']
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

              ],
              ),
            );
          });

  }
}




















/*











import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_v1/Pages/Dashboard/widgets/title_view.dart';
import 'package:front_v1/Pages/DevicePage/testFile.dart';
import 'package:front_v1/Pages/DevicePage/widgets/category_view.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/title_view_head.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/two_side_rounded_button.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

DatabaseHelper databaseHelper = new DatabaseHelper();

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<DeviceScreen>
    with TickerProviderStateMixin {
  PageController _pageController;
  int _selectedPage = 0;
  Animation<double> topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {


    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));


    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    setState(() {
      MyApp();
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 5;

    listViews.add(
      TitleViewHead(
        titleTxt: 'What you \nhave ',
        titleTxt2: 'For now ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );




//    listViews.add(
//      categoryListView(
//        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 5, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );


    listViews.add(MyApp());
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  10,
              bottom: 50 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Devices',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Image(
                                height: 40,
                                width: 40,
                                image: AssetImage(
                                  'assets/images/userr.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 2, bottom: 18),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child:FutureBuilder(
                future: databaseHelper.getData(),
                builder: (context,snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ?  ItemList(list: snapshot.data)
                      :  Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.nearlyDarkGeen
                    ),
                  ),
                  );
                }),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget{
  List list;
  ItemList({this.list});

  ScrollController _controller = new ScrollController();


  @override
    Widget build(BuildContext context) {
      return ListView.builder(
          itemCount: list == null ? 0 : list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            String imagechoice() {
              var grade = list[i]['category'];
              switch (grade) {
                case "humains":
                  {
                    return 'assets/images/onedevice/plant1.png';
                  }
                  break;
                case "animals":
                  {
                    return 'assets/images/onedevice/plant0.png';
                  }
                  break;
                case "car":
                  {
                    return 'assets/images/onedevice/plant2.png';
                  }
                  break;
                case "object":
                  {
                    return 'assets/images/onedevice/obj.png';
                  }
                  break;
              }
            }
            IconData iconchoice() {
              var grade = list[i]['category'];
              switch (grade) {
                case "humains":
                  {
                    return Icons.person_outline;
                  }
                  break;
                case "animals":
                  {
                    return Icons.adb;
                  }
                  break;
                case "cars":
                  {
                    return Icons.local_shipping;
                  }
                  break;
                case "objects":
                  {
                    return Icons.child_friendly;
                  }
                  break;
              }
            }
            IconData likechoice() {
              var grade = list[i]['favorit'];
              switch (grade) {
                case true:
                  {
                    return Icons.favorite;
                  }
                  break;
                case false:
                  {
                    return Icons.favorite_border;
                  }
                  break;
              }
            }
            DateTime t = DateTime.parse(list[i]['date_published'].toString());
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2),

              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.7,

              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 221,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ),
                  Image.asset(
                    imagechoice(),
                    width: 150,
                  ),
                  Positioned(
                    top: 60,
                    left: MediaQuery.of(context).size.width / 3.2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            'Device name is',
                            style: GoogleFonts.exo2(
                              color: Color(0xFF8F8F8F),
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            list[i]['title'],
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            'Created at',
                            style: GoogleFonts.exo2(
                              color: Color(0xFF8F8F8F),
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            DateFormat.yMMMMEEEEd().format(t).toString(),
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 160,
                    child: Container(
                      height: 85,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  width: 110,
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(3, 7),
                                          blurRadius: 20,
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          likechoice(),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TwoSideRoundedButton(
                                  text: "Read more ..",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DeviceShowDetails(
                                              list: list,
                                              index: i,
                                              slugg: list[i]['_id']
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

              ],
              ),
            );
          });

  }
}

























 */
