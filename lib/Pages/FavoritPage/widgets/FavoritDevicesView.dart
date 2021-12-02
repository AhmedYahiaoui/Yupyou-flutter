import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front_v1/Pages/FavoritPage/widgets/two_side_rounded_button.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

class FavoritDevicesView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  FavoritDevicesView(
      {Key key, this.animationController, this.animation})
      : super(key: key);

  final DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  void initState() {

//    users = databaseHelper.count_devices_By_User();

  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child:  Transform(
            transform:  Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 2, bottom: 18),
              child: Container(
                  child:  Container(
                    height: MediaQuery.of(context).size.width *1.35 ,
                    child:FutureBuilder<List>(
                      future: databaseHelper.getFavoritDevices(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ?  ItemList(list: snapshot.data)
                            :  Center(
                          child:  CircularProgressIndicator(
                            valueColor:  AlwaysStoppedAnimation<Color>(
                                AppTheme.nearlyDarkGeen),
                          ),
                        );
                      },
                    ),
                  ),
              ),
            ),
          ),
        );
      },
    );
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

//          DateTime t = list[i]['date_published'] ;
          DateTime t = DateTime.parse(list[i]['date_published'].toString());

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
                          DateFormat.yMMMMEEEEd().format(t).toString(),
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
                            style: Theme.of(context).textTheme.title,
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
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    imagechoice(),
                    width: size.width * .37,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 40,
                    width: size.width * .3,
                    child: TwoSideRoundedButton(
                      text: "Details",
                      radious: 24,
                      press: () {},
                    ),
                  ),
                ),
              ],
            ),
          );











//          return  Container(
//            padding: const EdgeInsets.all(12.0),
//            child:  GestureDetector(
////              onTap: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (_) => DeviceDetails(
////                          list: list, index: i, slugg: list[i]['slug'])),
////                );
////              },
//
////              onTap: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (_) => DeviceShowDetails(
////                          list: list, index: i, slugg: list[i]['slug']
////                      )
////                  ),
////                );
////              },
//              child: Stack(children: <Widget>[
//                Positioned(
//                    left: 200.0,
//                    top: 25.0,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.only(
//                            topRight: Radius.circular(25.0),
//                            bottomRight: Radius.circular(25.0)),
//                        color: Colors.white,
//                      ),
//                      width: 175.0,
//                      height: 180.0,
//                      child: Column(
//                        children: <Widget>[
//                          SizedBox(height: 20.0),
//                          Row(children: <Widget>[
//                            Flexible(
//                                child:  Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(list[i]['title'],
//                                        style: TextStyle(
//                                          color: Colors.grey[600],
//                                          fontSize: 28.0,
//                                          fontWeight: FontWeight.bold,
//                                        )),
//                                  ],
//                                )),
//                            SizedBox(width: 20.0),
//                            Icon(iconchoice(),
//                                size: 30, color: AppTheme.nearlyDarkGeen),
//                          ]),
//                          SizedBox(height: 20.0),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              Text(" Category : ${list[i]['category']}",
//                                  style: TextStyle(
//                                    color: Colors.grey[400],
//                                    fontSize: 14.0,
//                                    fontWeight: FontWeight.w400,
//                                  )),
//                            ],
//                          ),
//                          SizedBox(height: 20.0),
//                          Row(children: <Widget>[
//                            Flexible(
//                                child:  Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Icon(Icons.access_time,
//                                        size: 20, color: AppTheme.nearlyDarkGeen),
//                                    Text(list[i]['date_published'],
//                                        style: TextStyle(
//                                          color: Colors.grey[400],
//                                          fontSize: 12.0,
//                                          fontWeight: FontWeight.w400,
//                                        )),
//                                  ],
//                                )),
//                          ]),
//                        ],
//                      ),
//                    )),
//                Positioned(
//                  child: Material(
//                      color: Colors.white,
//                      elevation: 14.0,
//                      borderRadius: BorderRadius.circular(24.0),
//                      child: Container(
//                        width: 200.0,
//                        height: 230.0,
//                        decoration:  BoxDecoration(
//                          border: Border.all(
//                            color: Colors.black,
//                            width: 1,
//                          ),
//                          borderRadius: BorderRadius.circular(24.0),
//                        ),
//                      )),
//                ),
//                Container(
//                  width: 220.0,
//                  height: 230.0,
//
//                  child: Hero(
//                    tag: list[i]['title'],
//                    child: Image(
//                      image: AssetImage(
//                        imagechoice(),
//                      ),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//              ]),
//            ),
//          );







        });
  }
}


