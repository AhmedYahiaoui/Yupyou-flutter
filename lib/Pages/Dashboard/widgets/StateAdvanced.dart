import 'package:flutter/material.dart';
import 'package:front_v1/Pages/Dashboard/widgets/wave_view.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'package:google_fonts/google_fonts.dart';

DatabaseHelper2 databaseHelper2 = DatabaseHelper2();

class AdvancedState extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final double radiusTopRight;
  final double radiusBottomRight;

  AdvancedState(
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
              child: Container(
                child:FutureBuilder(
                  future: databaseHelper2.LastDeviceByUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[



                            Container(
                              width: 55,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(80.0),
                                    bottomLeft: Radius.circular(80.0),
                                    bottomRight: Radius.circular(80.0),
                                    topRight: Radius.circular(80.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.grey.withOpacity(0.2),
                                      offset: const Offset(2, 2),
                                      blurRadius: 4),
                                ],
                              ),
                              child:Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/map/baby.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '50'
                                      ),
                                      Text(
                                          'Human'
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),















                          ],
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


/*















                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/map/baby.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '50'
                                      ),
                                      Text(
                                          'Human'
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/map/baby.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '50'
                                      ),
                                      Text(
                                          'Human'
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/map/baby.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '50'
                                      ),
                                      Text(
                                          'Human'
                                      ),
                                    ],
                                  ),















* */
