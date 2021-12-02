import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_v1/Models/Device.dart';
import 'package:front_v1/Pages/DevicePage/testFile.dart';
import 'package:front_v1/Pages/FavoritPage/favoritePage.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/two_side_rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_v1/Pages/FavoritPage/widgets/FavoritDevicesView.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/title_view.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/title_view_head.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';

import 'package:front_v1/Theme/app_theme.dart';
import 'package:intl/intl.dart';

final DatabaseHelper2 databaseHelper = DatabaseHelper2();

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MyFavoritScreenState createState() => _MyFavoritScreenState();
}

class _MyFavoritScreenState extends State<FavoritScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  final DatabaseHelper databaseHelper = new DatabaseHelper();

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
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleViewHead(
        titleTxt: 'What you \nlike ',
        titleTxt2: 'For now ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );



//    listViews.add(
//      FavoritDevicesView(
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );






    /*
    * * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
    */




    listViews.add(
        MyApp()
    );
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
            )
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
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
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
                          color: AppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
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
                                  'Favorit',
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
        )
      ],
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Future<List> futureDevices;


  void fetchUsers() async {
    futureDevices = databaseHelper.getFavorit();
  }



  @override
  void initState() {
    super.initState();
    futureDevices = databaseHelper.getFavorit();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(
        left: 24, right: 24, top: 2, bottom: 18),
        child: Container(
          height: MediaQuery.of(context).size.width *1.35 ,

            child : RefreshIndicator(
              color: Colors.white,
              backgroundColor: AppTheme.nearlyDarkGeen,
              child:FutureBuilder<List>(
                future: futureDevices,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ?  ItemList(list: snapshot.data)
                      :  Center(child:
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.nearlyDarkGeen
                    ),
                  ),
                  );
                },
              ),
              onRefresh: _getData,
            ),
//            child:FutureBuilder<List>(
//            future: futureDevices,
//            builder: (context, snapshot) {
//              if (snapshot.hasError) print(snapshot.error);
//              return snapshot.hasData
//                  ?  ItemList(list: snapshot.data)
//                  :  Center(child:
//              CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(
//                    AppTheme.nearlyDarkGeen
//                ),
//              ),
//              );
//            },
//          ),
        ),
      );
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer =  Completer<Null>();
    Timer timer =  Timer( Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future;
  }
}



class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return  ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          String imagechoice() {
            var grade = list[i]['category'];
            switch (grade) {
              case "human":
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

//          DateTime t = list[i]['date_published'] ;
//          DateTime t = DateTime.parse(list[i]['date_published'].toString());
          String t = list[i]['date_published'];
          var long2 = int.tryParse(t);
          var date = DateTime.fromMillisecondsSinceEpoch(long2);
          var formattedDate = DateFormat.yMMMMEEEEd().format(date);

          var _id = list[i]['_id'];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 205,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 24,
                      top: 24,
                      right: size.width * .35,
                    ),
                    height: 185,
                    width: double.infinity,
                    decoration: BoxDecoration(
//                      color: Color(0xFFEAEAEA).withOpacity(.45),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
//                          DateFormat.yMMMMEEEEd().format(t).toString(),
                    formattedDate,
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF8F8F8F),
                          ),
                        ),
                        SizedBox(height: 5),



//                        Text(
//                          "Device name is",
//                          style: TextStyle(
//                              color: Color(0xFF8F8F8F),
//                            fontSize: 20,
//                            style: GoogleFonts.getFont('Lato'),
//                          ),
//                        ),

                        Text(
                          'Device name is',
                          style: GoogleFonts.exo2(
                            color: Color(0xFF8F8F8F),
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            " ${list[i]['title']}",
                            style: GoogleFonts.exo2(
                              color: Colors.black,
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 26,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(3, 7),
                                    blurRadius: 20,
                                    color: Color(0xFD3D3D3).withOpacity(.5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "When the earth was flat and everyone wanted to win the game of the best and people….",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF8F8F8F),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),






//                Positioned(
//                  right: 0,
//                  top: 0,
//                  child:
//
//                  Image.asset(
//                    imagechoice(),
//                    width: size.width * .37,
//                  ),
//                ),




                Positioned(
                  right: 0,
                  top: 0,
                  child: Hero(
                    tag: _id.toString(),
                    child:Image.asset(
                      imagechoice(),
                      width: size.width * .37,
                    ),
                    transitionOnUserGestures: true,
                  ),
                ),

//                Image.asset(
//                  imagechoice(),
//                  width: size.width * .37,
//                ),
//
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 40,
                    width: size.width * .3,
                    child: TwoSideRoundedButton(
                      text: "Details",
                      radious: 24,
                      press: () {
                        Navigator.push(
                          context,
                          SizeRoute(
//                              transitionDuration: Duration(seconds: 2),
                              page: FavoritDetails(
                                  list: list, index: i, slugg: list[i]['_id']
                              )
                          ),
                        );


                        /*


                       Navigator.push(
                          context,
                          SizeRoute(
                              page: FavoritDetails(
                                  list: list, index: i, slugg: list[i]['_id']
                              )
                          ),
                        );



                        */

                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}


class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        ),
  );
}
