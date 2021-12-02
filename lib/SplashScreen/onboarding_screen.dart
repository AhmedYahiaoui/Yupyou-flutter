import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_v1/Pages/LoginPage/loginPage.dart';
import 'package:front_v1/Theme//styles.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 5.0,
      width: isActive ? 30.0 : 4.0,
      decoration: BoxDecoration(
        color: isActive ?
        AppTheme.nearlyDarkGeen
            :
        Colors.black,
//        Colors.green[900],
//        color: AppTheme.nearlyDarkGeen,

        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child:
                    Text(
                      'Skip',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.exo2(
                          color: Colors.black,
                          textStyle:
                          Theme.of(context).textTheme.display1,
                          fontWeight: FontWeight.w300,
                          fontSize: 22),
                    ),
//                    Text(
//                      'Skip',
//                      style: TextStyle(
////                        color: Colors.green[900],
//                        color: Colors.black,
//                        fontSize: 20.0,
//                      ),
//                    ),





                  ),
                ),
                Container(
//                  height: 600.0,
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: MediaQuery.of(context).size.width,

                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[




                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/SlpashScreen/slider_1.png',
                                ),
                                height: MediaQuery.of(context).size.height * 0.55,
                                width: MediaQuery.of(context).size.width * 0.7 ,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et'
                                  'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  textStyle:
                                  Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/SlpashScreen/slider_2.png',
                                ),
                                height: MediaQuery.of(context).size.height * 0.55,
                                width: MediaQuery.of(context).size.width * 0.7 ,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et'
                                  'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  textStyle:
                                  Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/SlpashScreen/slider_3.png',
                                ),
                                height: MediaQuery.of(context).size.height * 0.55,
                                width: MediaQuery.of(context).size.width * 0.7 ,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et'
                                  'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  textStyle:
                                  Theme.of(context).textTheme.display1,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.exo2(
                                      color: Colors.black,
                                      textStyle:
                                      Theme.of(context).textTheme.display1,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 75.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );

                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child:



//                    Text(
//                      'Get started',
//                      style: TextStyle(
//                        color: Colors.green[900],
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),

                    Text(
                      'Get started',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.exo2(
                          color: AppTheme.nearlyDarkGeen,
                          textStyle:
                          Theme.of(context).textTheme.display1,
                          fontWeight: FontWeight.w300,
                          fontSize: 22),
                    ),


                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
