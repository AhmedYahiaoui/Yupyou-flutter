import 'package:flutter/material.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

DatabaseHelper2 databaseHelper2 = DatabaseHelper2();

class BodyMeasurementView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final double radiusTopRight;
  final double radiusBottomRight;

  BodyMeasurementView(
      {Key key,
      this.animationController,
      this.animation,
      this.radiusTopRight,
      this.radiusBottomRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child:


              Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(radiusBottomRight),
                      topRight: Radius.circular(radiusTopRight)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),




                child:MyBodyMeasurementView(),










//                FutureBuilder(
//                  future: databaseHelper2.LastDeviceByUser(),
//                  builder: (context, snapshot) {
//                    if (snapshot.hasError) print(snapshot.error);
//                    return snapshot.hasData
//                        ? Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        SizedBox(
//                          height: 5,
//                        ),
//                        Row(
//                          children: <Widget>[
//                            SizedBox(
//                              width: 18,
//                            ),
//                            Text(
//                                'Device ',
//                                textAlign: TextAlign.center,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.darkText,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w200,
//                                  fontSize: 16,
//                                )
//                            ),
//                          ],
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Container(
//                              height: 48,
//                              width: 2,
//                              decoration: BoxDecoration(
//                                color: AppTheme.nearlyDarkGeen
//                                    .withOpacity(0.5),
//                                borderRadius: BorderRadius.all(
//                                    Radius.circular(4.0)),
//                              ),
//                            ),
//
//                            SizedBox(
//                              width: 10,
//                            ),
//
//                            SizedBox(
//                              width: MediaQuery.of(context).size.width*0.25,
//                            ),
//                            Text(
//                                '${snapshot.data.title}',
//                                textAlign: TextAlign.center,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.nearlyDarkGeen,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w300,
//                                  fontSize: 35,
//                                )
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          height: 5,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//
//                            Text(
//                                '${snapshot.data.category}',
//                                textAlign: TextAlign.left,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.nearlyDarkGeen,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 14,
//                                )
//                            ),
//
//
//                            Row(
//                              children: <Widget>[
//                                Icon(
//                                  Icons.access_time,
//                                  color: AppTheme.grey
//                                      .withOpacity(0.5),
//                                  size: 16,
//                                ),
//
//                                Text(
//                                    '${DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(snapshot.data.date_published))).toString()}',
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    fontFamily:
//                                    AppTheme.fontName,
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 14,
//                                    letterSpacing: 0.0,
//                                    color: AppTheme.grey
//                                        .withOpacity(0.5),
//                                  ),
//                                ),
//                              ],
//                            ),
//
//
//                            Column(
//                              children: [
//                                snapshot.data.favorit == true?
//                                Icon(
//                                  Icons.favorite,
//                                  color: Colors.red.withOpacity(0.5),
//                                  size: 20,
//                                )
//                                    :Icon(
//                                  Icons.favorite_border,
//                                  color: Colors.red.withOpacity(0.5),
//                                  size: 20,
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          height: 20,
//                        ),
//                      ],
//                    )
//                        : Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        SizedBox(
//                          height: 5,
//                        ),
//                        Row(
//                          children: <Widget>[
//                            SizedBox(
//                              width: 15,
//                            ),
//                            Text(
//                                'No device found !! ',
//                                textAlign: TextAlign.center,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.darkText,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w200,
//                                  fontSize: 16,
//                                )
//                            ),
//                          ],
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Container(
//                              height: 48,
//                              width: 2,
//                              decoration: BoxDecoration(
//                                color: AppTheme.nearlyDarkGeen
//                                    .withOpacity(0.5),
//                                borderRadius: BorderRadius.all(
//                                    Radius.circular(4.0)),
//                              ),
//                            ),
//
//                            SizedBox(
//                              width: 10,
//                            ),
//
//                            Text(
//                                ' .... ',
//                                textAlign: TextAlign.center,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.nearlyDarkGeen,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 30,
//                                )
//                            ),
//
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//
//                            Text(
//                                ' .... ',
//                                textAlign: TextAlign.left,
//                                style: GoogleFonts.exo2(
//                                  color: AppTheme.nearlyDarkGeen,
//                                  textStyle: Theme.of(context).textTheme.display1,
//                                  fontWeight: FontWeight.w400,
//                                  fontSize: 14,
//                                )
//                            ),
//
//
//                            Row(
//                              children: <Widget>[
//                                Icon(
//                                  Icons.access_time,
//                                  color: AppTheme.grey
//                                      .withOpacity(0.5),
//                                  size: 16,
//                                ),
//
//                                Text(
//                                  ' .... ',
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    fontFamily:
//                                    AppTheme.fontName,
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 14,
//                                    letterSpacing: 0.0,
//                                    color: AppTheme.grey
//                                        .withOpacity(0.5),
//                                  ),
//                                ),
//                              ],
//                            )
//
//
//
//
//
//
//
//                          ],
//                        ),
//                        SizedBox(
//                          height: 5,
//                        ),
//                      ],
//                    );
//                    },
//                ),





              ),


            ),
          ),
        );
      },
    );
  }
}


class MyBodyMeasurementView extends StatefulWidget {
  @override
  State<MyBodyMeasurementView> createState() => MyBodyMeasurementViewState();
}

class MyBodyMeasurementViewState extends State<MyBodyMeasurementView> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: databaseHelper2.LastDeviceByUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
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
          },
      );
  }
}
