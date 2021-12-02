import 'package:flutter/material.dart';
import 'package:front_v1/Models/User.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final DatabaseHelper2 databaseHelper = DatabaseHelper2();
class PictureView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  const PictureView({Key key, this.animationController, this.animation})
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
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: <Widget>[
                    FutureBuilder<User>(
                      future: databaseHelper.Profile(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String t = snapshot.data.date_joined;
                          var long2 = int.tryParse(t);
                          var date = DateTime.fromMillisecondsSinceEpoch(long2);
                          var formattedDate = DateFormat.yMMMMEEEEd().format(date);
                          return Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Image(
                                        height: 120,
                                        width: 120,
                                        image: AssetImage(
                                          'assets/images/userr.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.exo2(
                                          color: Color(0xFF8F8F8F),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "Hi ,",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text:
                                                  '${snapshot.data.username[0].toUpperCase()}${snapshot.data.username.substring(1)}')
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.exo2(
                                          color: Color(0xFF8F8F8F),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "Joined us :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          TextSpan(
                                              text: formattedDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                  fontSize: 15))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.exo2(
                                          color: Color(0xFF8F8F8F),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "Your phone number : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          TextSpan(
                                              text: '+ 216'+'${snapshot.data.numTel.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                  fontSize: 15))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.exo2(
                                    color: Color(0xFF8F8F8F),
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${snapshot.data.email[0].toUpperCase()}${snapshot.data.email.substring(1)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image(
                                      height: 120,
                                      width: 120,
                                      image: AssetImage(
                                        'assets/images/userr.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.exo2(
                                        color: Color(0xFF8F8F8F),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "Hi ,",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black)),
                                        TextSpan(
                                            text:
                                            'Loading ... ')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.exo2(
                                        color: Color(0xFF8F8F8F),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "Joined us :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                                fontSize: 15)),
                                        TextSpan(
//                                              text: '${DateFormat.yMMMMEEEEd().format(snapshot.data.date_joined).toString()}',
                                            text: 'Loading ... ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                                fontSize: 15))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.exo2(
                                        color: Color(0xFF8F8F8F),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "Your phone number : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                                fontSize: 15)),
                                        TextSpan(
                                            text: 'Loading ... ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                                fontSize: 15))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.exo2(
                                  color: Color(0xFF8F8F8F),
                                  textStyle:
                                  Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w100,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Loading ... ',
                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ],
                        );;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
