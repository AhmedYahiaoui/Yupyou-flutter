import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front_v1/Models/User.dart';
import 'package:front_v1/Pages/Dashboard/widgets/BarChartSample.dart';
import 'package:front_v1/Pages/Dashboard/widgets/LastDeviceAdded.dart';
import 'package:front_v1/Pages/Dashboard/widgets/StateAdvanced.dart';
import 'package:front_v1/Pages/Dashboard/widgets/glass_view.dart';
import 'package:front_v1/Pages/Dashboard/widgets/line_chart_sample.dart';
import 'package:front_v1/Pages/Dashboard/widgets/mapview.dart';
import 'package:front_v1/Pages/Dashboard/widgets/meals_list_view.dart';
import 'package:front_v1/Pages/Dashboard/widgets/mediterranesn_diet_view.dart';
import 'package:front_v1/Pages/Dashboard/widgets/pie_chart_sample.dart';
import 'package:front_v1/Pages/Dashboard/widgets/title_view.dart';


//import 'package:front_v1/Pages/Dashboard/widgets/title_view.dart';



import 'package:front_v1/Pages/Dashboard/widgets/water_view.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'package:front_v1/test.dart';
import 'package:front_v1/Pages/Dashboard/widgets/MapView2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<DashScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  final DatabaseHelper databaseHelper = new DatabaseHelper();
  final DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;


//  Future loaddata() async {
//    print("Loading Devices ..");
//    await databaseHelper.getAllData2().then((devices) {
////      for (var data in devices) {
////        List items = data["line_items"];
//        for (int i = 0; i < devices.length; i++) {
//
//          String title = devices[i]["title"];
//          print("****************     title ****************");
//          print(title);
//
//          if (devices.isNotEmpty){
////            int id = devices[i]["device_data"][devices.length-1];
//            print("****************     devices[i][device_data][devices.length-1]  ****************");
//            print(devices[i]["device_data"][0]['lat']);
//          }
//
//
//        }
////      }
//
//
//
////      print('Devices ${devices[0]['device_data'][1].toString()}');
//
//    });
//  }



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

//    loaddata();
    super.initState();
  }


  void addAllListData() {
    int count = 9;


    listViews.add(
      TitleView(
        titleTxt: 'Welcome  ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

//    listViews.add(
//      Row(
//        children: <Widget>[
//          SizedBox(
//          width: 40,
//          ),
//          FutureBuilder<User>(
//            future: databaseHelper.getUser(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return
//                  Text(
//                      '${snapshot.data.username[0].toUpperCase()}${snapshot.data.username.substring(1)}',
//                    textAlign: TextAlign.center,
//                    style: GoogleFonts.exo2(
//                      color: Color(0xFF8F8F8F),
//                      textStyle: Theme.of(context).textTheme.display1,
//                      fontWeight: FontWeight.w200,
//                    ),
//                  );
//              } else if (snapshot.hasError) {
//                return Text("${snapshot.error}");
//              }
//              return
//                TitleView(
//                titleTxt: 'Loading ..  ',
//                animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                    parent: widget.animationController,
//                    curve:
//                    Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
//                animationController: widget.animationController,
//              );
//            },
//          ),
//        ],
//      ),
//    );


    listViews.add(
      Row(
        children: <Widget>[
          SizedBox(
          width: 40,
          ),
          FutureBuilder<User>(
            future: databaseHelper2.Profile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return
                  Text(
                      '${snapshot.data.username[0].toUpperCase()}${snapshot.data.username.substring(1)}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.exo2(
                      color: Color(0xFF8F8F8F),
                      textStyle: Theme.of(context).textTheme.display1,
                      fontWeight: FontWeight.w200,
                    ),
                  );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return

                Text(
                  'Loading ..  ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.exo2(
                    color: Color(0xFF8F8F8F),
                    textStyle: Theme.of(context).textTheme.display1,
                    fontWeight: FontWeight.w200,
                  ),
                );
            },
          ),
        ],
      ),
    );













//    listViews.add(
//      MediterranesnDietView(
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );



//    listViews.add(
//      TitleView(
//        titleTxt: 'Categories',
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

    listViews.add(
      MapView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        radiusTopRight: 68.0,
        radiusBottomRight: 8.0,
      ),
    );


    listViews.add(
      TitleView(
        titleTxt: 'Last added',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );


//    listViews.add(
//      BodyMeasurementView(
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//        radiusTopRight: 68.0,
//        radiusBottomRight: 8.0,
//      ),
//    );






    listViews.add(
      Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child:FutureBuilder(
                  future: databaseHelper2.LastDeviceByUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);




                    if(snapshot.hasData){

                      if(snapshot.data.title != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                    'Device ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.darkText,
                                      textStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .display1,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                    )
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyDarkGeen
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)),
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.25,
                                ),
                                Text(
                                    '${snapshot.data.title}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.nearlyDarkGeen,
                                      textStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .display1,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 35,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Text(
                                    '${snapshot.data.category}',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.nearlyDarkGeen,
                                      textStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .display1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )
                                ),


                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: AppTheme.grey
                                          .withOpacity(0.5),
                                      size: 16,
                                    ),

                                    Text(
                                      '${DateFormat.yMMMMEEEEd()
                                          .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.tryParse(snapshot.data
                                                  .date_published)))
                                          .toString()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily:
                                        AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: AppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),


                                Column(
                                  children: [
                                    snapshot.data.favorit == true ?
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red.withOpacity(0.5),
                                      size: 20,
                                    )
                                        : Icon(
                                      Icons.favorite_border,
                                      color: Colors.red.withOpacity(0.5),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                      else{
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                    'No device found !! ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.darkText,
                                      textStyle: Theme.of(context).textTheme.display1,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                    )
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: AppTheme.nearlyDarkGeen
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0)),
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                    ' .... ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.nearlyDarkGeen,
                                      textStyle: Theme.of(context).textTheme.display1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                    )
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Text(
                                    ' .... ',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.exo2(
                                      color: AppTheme.nearlyDarkGeen,
                                      textStyle: Theme.of(context).textTheme.display1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )
                                ),


                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: AppTheme.grey
                                          .withOpacity(0.5),
                                      size: 16,
                                    ),

                                    Text(
                                      ' .... ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily:
                                        AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: AppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                )







                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      }

                    }
                    else{
                      return CircularProgressIndicator();;
                    }



/*



                    return snapshot.hasData
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 18,
                            ),
                            Text(
                                'Device ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.darkText,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyDarkGeen
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.25,
                            ),
                            Text(
                                '${snapshot.data.title}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.nearlyDarkGeen,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 35,
                                )
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text(
                                '${snapshot.data.category}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.nearlyDarkGeen,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                )
                            ),


                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: AppTheme.grey
                                      .withOpacity(0.5),
                                  size: 16,
                                ),

                                Text(
                                    '${DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(snapshot.data.date_published))).toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                    AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: AppTheme.grey
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),


                            Column(
                              children: [
                                snapshot.data.favorit == true?
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red.withOpacity(0.5),
                                  size: 20,
                                )
                                    :Icon(
                                  Icons.favorite_border,
                                  color: Colors.red.withOpacity(0.5),
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                                'No device found !! ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.darkText,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 2,
                              decoration: BoxDecoration(
                                color: AppTheme.nearlyDarkGeen
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4.0)),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            Text(
                                ' .... ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.nearlyDarkGeen,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30,
                                )
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text(
                                ' .... ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.exo2(
                                  color: AppTheme.nearlyDarkGeen,
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                )
                            ),


                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: AppTheme.grey
                                      .withOpacity(0.5),
                                  size: 16,
                                ),

                                Text(
                                  ' .... ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily:
                                    AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: AppTheme.grey
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            )







                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    );












* */

                    },
                ),
      ),
        ),
    );



//
//    listViews.add(
//      TitleView(
//        titleTxt: 'Water',
////        subTxt: 'Aqua SmartBottle',
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//
//
//    listViews.add(
//      WaterView(
//        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 7, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );



    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );





//    listViews.add(
//      TitleView(
//        titleTxt: 'State',
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

    listViews.add(
      TitleView(
        titleTxt: 'Simple click .. \n'
            'And get device(s) per month ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );




    listViews.add(
        SizedBox(
          height: 10,
        )
    );




    listViews.add(
        Padding(
          padding: const EdgeInsets.all(18),
          child: PieChartSample2(),
        ),
    );



    listViews.add(
      Padding(
        padding: const EdgeInsets.all(18),
        child: BarChartSample(),
      ),
    );


    listViews.add(
      SizedBox(
        height: 20,
      )
    );


//
//
//
//    listViews.add(
//        Padding(
//          padding: const EdgeInsets.all(18),
//          child: PieChartSample2(),
//        ),
//    );








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
                                  'Dashboard',
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
