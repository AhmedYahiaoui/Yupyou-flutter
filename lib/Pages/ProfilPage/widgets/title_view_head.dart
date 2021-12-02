import 'package:flutter/material.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleViewHead extends StatelessWidget {
  final String titleTxt;
  final String titleTxt2;
  final String subTxt;
  final AnimationController animationController;
  final Animation animation;

  const TitleViewHead(
      {Key key,
      this.titleTxt: "",
      this.titleTxt2: "",
      this.subTxt: "",
      this.animationController,
      this.animation})
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.exo2(
                            color: Color(0xFF8F8F8F),
                            textStyle: Theme.of(context).textTheme.display1,
                            fontWeight: FontWeight.w100,
                          ),
                          children: [
                            TextSpan(text: titleTxt),
                            TextSpan(
                                text: titleTxt2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: AppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
