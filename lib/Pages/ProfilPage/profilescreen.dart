import 'dart:async';

import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
import 'package:flutter/material.dart';
import 'package:front_v1/Animation/FadeAnimation.dart';
import 'package:front_v1/Models/User.dart';
import 'package:front_v1/Pages/Dashboard/widgets/glass_view.dart';
import 'package:front_v1/Pages/LoginPage/loginPage.dart';
import 'package:front_v1/Pages/ProfilPage//widgets/title_view_head.dart';
import 'package:front_v1/Pages/ProfilPage/widgets/HomePageDialogflow.dart';
import 'package:front_v1/Pages/ProfilPage/widgets/picture_view.dart';
import 'package:front_v1/Pages/ProfilPage/widgets/profile_options.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

final DatabaseHelper2 databaseHelper = DatabaseHelper2();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}
class _MyProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

//  var textController =  TextEditingController();


  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)
        )
    );
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




   TextEditingController nameController ;
   TextEditingController emailController ;
   TextEditingController phonedController ;

   TextEditingController passwordController = TextEditingController();
   TextEditingController newpasswordController= TextEditingController();
   TextEditingController newpassword2Controller = TextEditingController();



  final RoundedLoadingButtonController _btnController =  RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnPasswordController =  RoundedLoadingButtonController();

  DatabaseHelper2 databaseHelper2 =  DatabaseHelper2();
  final _key= GlobalKey<FormState>();
  final _keyPassword= GlobalKey<FormState>();

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleViewHead(
        titleTxt: 'Who you \nare ',
        titleTxt2: 'For now ',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );




//    listViews.add(
//      PictureView(
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );


    // Hi , user name
    listViews.add(
      Container(
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
    );









    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );



    listViews.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[

                  //User setting
                  ExpansionTile(

                    title: Text('User setting ',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.exo2(
                        color: Color(0xFF8F8F8F),
                        fontWeight: FontWeight.w300,
                        fontSize: 18
                      ),
                    ),

                    leading: Image(height: 70, width: 65,
                      image: AssetImage('assets/images/user/setting_user.png'),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    children: <Widget>[
//                      FutureBuilder<User>(
//                        future: databaseHelper.Profile(),
//                        builder: (context, snapshot) {
//                          if (snapshot.hasData) {
//
//                            return
//
////                              Column(
////                              children: <Widget>[
////                                Row(children: <Widget>[
////                                  Column(
////                                    children: <Widget>[
////                                      RichText(
////                                        text: TextSpan(
////                                          style: GoogleFonts.exo2(
////                                            color: Color(0xFF8F8F8F),
////                                            textStyle: Theme.of(context)
////                                                .textTheme
////                                                .display1,
////                                            fontWeight: FontWeight.w100,
////                                          ),
////                                          children: [
////                                            TextSpan(
////                                                text: "Hi ,",
////                                                style: TextStyle(
////                                                    fontWeight: FontWeight.w900,
////                                                    color: Colors.black)),
////                                            TextSpan(
////                                                text:
////                                                '${snapshot.data.username[0].toUpperCase()}${snapshot.data.username.substring(1)}')
////                                          ],
////                                        ),
////                                      ),
////                                      SizedBox(
////                                        height: 5,
////                                      ),
////                                      RichText(
////                                        text: TextSpan(
////                                          style: GoogleFonts.exo2(
////                                            color: Color(0xFF8F8F8F),
////                                            textStyle: Theme.of(context)
////                                                .textTheme
////                                                .display1,
////                                            fontWeight: FontWeight.w100,
////                                          ),
////                                        ),
////                                      ),
////                                      SizedBox(
////                                        height: 5,
////                                      ),
////                                      RichText(
////                                        text: TextSpan(
////                                          style: GoogleFonts.exo2(
////                                            color: Color(0xFF8F8F8F),
////                                            textStyle: Theme.of(context)
////                                                .textTheme
////                                                .display1,
////                                            fontWeight: FontWeight.w100,
////                                          ),
////                                          children: [
////                                            TextSpan(
////                                                text: "Your phone number : ",
////                                                style: TextStyle(
////                                                    fontWeight: FontWeight.w900,
////                                                    color: Colors.black,
////                                                    fontSize: 15)),
////                                            TextSpan(
////                                                text: '+ 216'+'${snapshot.data.numTel.toString()}',
////                                                style: TextStyle(
////                                                    fontWeight: FontWeight.w900,
////                                                    color: Colors.black,
////                                                    fontSize: 15))
////                                          ],
////                                        ),
////                                      ),
////                                    ],
////                                  ),
////                                ]),
////                                SizedBox(
////                                  height: 10,
////                                ),
////                                RichText(
////                                  text: TextSpan(
////                                    style: GoogleFonts.exo2(
////                                      color: Color(0xFF8F8F8F),
////                                      textStyle:
////                                      Theme.of(context).textTheme.display1,
////                                      fontWeight: FontWeight.w100,
////                                    ),
////                                    children: [
////                                      TextSpan(
////                                          text:
////                                          '${snapshot.data.email[0].toUpperCase()}${snapshot.data.email.substring(1)}',
////                                          style: TextStyle(
////                                              fontWeight: FontWeight.w700,
////                                              color: Colors.black,
////                                              fontSize: 20)),
////                                    ],
////                                  ),
////                                ),
////                              ],
////                            );
//
//
//                          } else if (snapshot.hasError) {
//                            return Text("${snapshot.error}");
//                          }
//
//                          return
//
////                            Column(
////                            children: <Widget>[
////                              Row(children: <Widget>[
////                                Expanded(
////                                  child: Column(
////                                    children: <Widget>[
////                                      SizedBox(
////                                        height: 10,
////                                      ),
////                                      Image(
////                                        height: 120,
////                                        width: 120,
////                                        image: AssetImage(
////                                          'assets/images/userr.png',
////                                        ),
////                                        fit: BoxFit.fill,
////                                      ),
////                                    ],
////                                  ),
////                                ),
////                                Column(
////                                  children: <Widget>[
////                                    RichText(
////                                      text: TextSpan(
////                                        style: GoogleFonts.exo2(
////                                          color: Color(0xFF8F8F8F),
////                                          textStyle: Theme.of(context)
////                                              .textTheme
////                                              .display1,
////                                          fontWeight: FontWeight.w100,
////                                        ),
////                                        children: [
////                                          TextSpan(
////                                              text: "Hi ,",
////                                              style: TextStyle(
////                                                  fontWeight: FontWeight.w900,
////                                                  color: Colors.black)),
////                                          TextSpan(
////                                              text:
////                                              'Loading ... ')
////                                        ],
////                                      ),
////                                    ),
////                                    SizedBox(
////                                      height: 5,
////                                    ),
////                                    RichText(
////                                      text: TextSpan(
////                                        style: GoogleFonts.exo2(
////                                          color: Color(0xFF8F8F8F),
////                                          textStyle: Theme.of(context)
////                                              .textTheme
////                                              .display1,
////                                          fontWeight: FontWeight.w100,
////                                        ),
////                                        children: [
////                                          TextSpan(
////                                              text: "Joined us :",
////                                              style: TextStyle(
////                                                  fontWeight: FontWeight.w900,
////                                                  color: Colors.black,
////                                                  fontSize: 15)),
////                                          TextSpan(
//////                                              text: '${DateFormat.yMMMMEEEEd().format(snapshot.data.date_joined).toString()}',
////                                              text: 'Loading ... ',
////                                              style: TextStyle(
////                                                  fontWeight: FontWeight.w900,
////                                                  color: Colors.black,
////                                                  fontSize: 15))
////                                        ],
////                                      ),
////                                    ),
////                                    SizedBox(
////                                      height: 5,
////                                    ),
////                                    RichText(
////                                      text: TextSpan(
////                                        style: GoogleFonts.exo2(
////                                          color: Color(0xFF8F8F8F),
////                                          textStyle: Theme.of(context)
////                                              .textTheme
////                                              .display1,
////                                          fontWeight: FontWeight.w100,
////                                        ),
////                                        children: [
////                                          TextSpan(
////                                              text: "Your phone number : ",
////                                              style: TextStyle(
////                                                  fontWeight: FontWeight.w900,
////                                                  color: Colors.black,
////                                                  fontSize: 15)),
////                                          TextSpan(
////                                              text: 'Loading ... ',
////                                              style: TextStyle(
////                                                  fontWeight: FontWeight.w900,
////                                                  color: Colors.black,
////                                                  fontSize: 15))
////                                        ],
////                                      ),
////                                    ),
////                                  ],
////                                ),
////                              ]),
////                              SizedBox(
////                                height: 10,
////                              ),
////                              RichText(
////                                text: TextSpan(
////                                  style: GoogleFonts.exo2(
////                                    color: Color(0xFF8F8F8F),
////                                    textStyle:
////                                    Theme.of(context).textTheme.display1,
////                                    fontWeight: FontWeight.w100,
////                                  ),
////                                  children: [
////                                    TextSpan(
////                                        text: 'Loading ... ',
////                                        style: TextStyle(
////                                            fontWeight: FontWeight.w700,
////                                            color: Colors.black,
////                                            fontSize: 20)),
////                                  ],
////                                ),
////                              ),
////                            ],
////                          );;
//
//                        },
//                      ),





//                      textSection(),



                      FadeAnimation(
                          0.5,
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]
                              ),


                                child:FutureBuilder<User>(
                                  future: databaseHelper.Profile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: <Widget>[

                                          Form(
                                            key: _key,
                                            child:Column(
                                              children: <Widget>[
                                                //name
                                                Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      border:
                                                      Border(bottom: BorderSide(color: Colors.grey[100]))),
                                                  child: TextFormField(
                                                controller :nameController = TextEditingController(text: snapshot.data.username),
                                                decoration: InputDecoration(
                                                    icon: Icon(Icons.person, color: Colors.grey[400]),
                                                    border: InputBorder.none,
                                                    hintText: "Username",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                                validator: (value){
                                                  if (value.isEmpty){
                                                    return " Username can not be empty";
                                                  }else if (value.length <= 2)
                                                  {
                                                    return"User name should be greater then 2 caractere";
                                                  }else
                                                    return null;
                                                },
                                              ),
                                            ),

                                                //email
                                                Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  border:
                                                  Border(bottom: BorderSide(color: Colors.grey[100]))),
                                              child: TextFormField(

                                                controller: emailController= TextEditingController(text: snapshot.data.email),
                                                decoration: InputDecoration(
                                                    icon: Icon(Icons.email, color: Colors.grey[400]),
                                                    border: InputBorder.none,
                                                    hintText: "Email",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                                validator: (value){
                                                  if (value.isEmpty){
                                                    return " Mail can not be empty";
                                                  }else if (value.length <= 5)
                                                  {
                                                    return" Mail should be greater then 5";
                                                  }else
                                                    return null;
                                                },

                                              ),
                                            ),

                                                //phone
                                                Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  border:
                                                  Border(bottom: BorderSide(color: Colors.grey[100]))),
                                              child: TextFormField(
                                                validator: (value){
                                                  if (value.isEmpty){
                                                    return " Phone number can not be empty";
                                                  }else if (value.length <= 5)
                                                  {
                                                    return"Phone number should be greater then 8";
                                                  }else
                                                    return null;
                                                },
                                                controller: phonedController= TextEditingController(text: snapshot.data.numTel.toString()),
//                                                initialValue: snapshot.data.numTel.toString(),

                                                decoration: InputDecoration(
                                                    icon: Icon(Icons.phone_android, color: Colors.grey[400]),
                                                    border: InputBorder.none,
                                                    hintText: "Phone number",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),







                                            // button update user
                                            FadeAnimation(
                                              0.8,
                                              Container(
                                                height: 50,
                                                child: AspectRatio(
                                                  child: RoundedLoadingButton(
                                                    color: HexColor('#54D3C2'),
                                                    child: Text("Update",
                                                        style: TextStyle(color: Colors.white)
                                                    ),
                                                    controller: _btnController,
                                                    onPressed: _updateUser,
                                                  ),
                                                  aspectRatio: 8,
                                                ),
                                              ),
                                            ),


                                            SizedBox(height: 5),

                                            Divider(
                                              color: Colors.grey,
                                              height: 1,
                                              thickness: 1,
                                              indent: 0,
                                              endIndent: 0,
                                            ),

                                            SizedBox(height: 1.5),

                                          ],
                                        ),
                                      ),

                                          Form(
                                            key: _keyPassword,
                                            child:Column(
                                              children: <Widget>[

                                                //pass_old
                                                Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: passwordController,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(Icons.lock, color: Colors.grey[400]),
                                                        hintText: "Old Password",
                                                        hintStyle: TextStyle(color: Colors.grey[400])),
                                                    validator: (value){
                                                      if (value.isEmpty){
                                                        return " Password can not be empty";
                                                      }else
                                                        return null;
                                                    },
                                                  ),
                                                ),

                                                //pass_new1
                                                Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    validator: (value){
                                                      if (value.isEmpty){
                                                        return " Password can not be empty";
                                                      }else
                                                        return null;
                                                    },
                                                    controller: newpasswordController,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                                                        hintText: "New Password",
                                                        hintStyle: TextStyle(color: Colors.grey[400])),
                                                  ),
                                                ),

                                                //pass_new2
                                                Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    validator: (value){
                                                      if (value.isEmpty){
                                                        return " Password can not be empty";
                                                      }else
                                                        return null;
                                                    },
                                                    controller: newpassword2Controller,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                                                        hintText: "Confirm Password",
                                                        hintStyle: TextStyle(color: Colors.grey[400])),
                                                  ),
                                                ),

                                                // button update password
                                                FadeAnimation(
                                                  0.8,
                                                  Container(
                                                    height: 50,
                                                    child: AspectRatio(
                                                      child: RoundedLoadingButton(
                                                        color: HexColor('#54D3C2'),
                                                        child: Text("Update Password", style: TextStyle(color: Colors.white)),
                                                        controller: _btnPasswordController,
                                                        onPressed: (){
                                                          _updateUserPassword(snapshot.data.password.toString());
                                                        },
                                                      ),
                                                      aspectRatio: 8,
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                        ],
                                      );
                                    } else
                                      if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return Column(
                                    children: <Widget>[




                                    //name
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                    border:
                                    Border(bottom: BorderSide(color: Colors.grey[100]))),
                                    child: TextFormField(
                                    validator: (value){
                                    if (value.isEmpty){
                                    return " Username can not be empty";
                                    }else if (value.length <= 5)
                                    {
                                    return"User name should be greater then 5";
                                    }else
                                    return null;
                                    },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                    icon: Icon(Icons.person, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),



                                    //email
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                    border:
                                    Border(bottom: BorderSide(color: Colors.grey[100]))),
                                    child: TextFormField(
                                    validator: (value){
                                    if (value.isEmpty){
                                    return " Mail can not be empty";
                                    }else if (value.length <= 5)
                                    {
                                    return" Mail should be greater then 5";
                                    }else
                                    return null;
                                    },
                                    controller: emailController,
                                    decoration: InputDecoration(
                                    icon: Icon(Icons.email, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),



                                    //num
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                    border:
                                    Border(bottom: BorderSide(color: Colors.grey[100]))),
                                    child: TextFormField(
                                    validator: (value){
                                    if (value.isEmpty){
                                    return " Phone number can not be empty";
                                    }else if (value.length <= 5)
                                    {
                                    return"Phone number should be greater then 8";
                                    }else
                                    return null;
                                    },
                                    controller: phonedController,
                                    decoration: InputDecoration(
                                    icon: Icon(Icons.phone_android, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Phone number",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),



                                    SizedBox(height: 1.5),

                                    Divider(
                                    color: Colors.grey,
                                    height: 1,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                    ),

                                    SizedBox(height: 1.5),


                                    //pass_old
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                    validator: (value) =>
                                    value.isEmpty ? 'Password cannot be blank' : null,
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock, color: Colors.grey[400]),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),




                                    //pass_new1
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                    validator: (value) =>
                                    value.isEmpty ? 'Password cannot be blank' : null,
                                    controller: newpasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                                    hintText: "the new Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),



                                    //pass_new2
                                    Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                    validator: (value) =>
                                    value.isEmpty ? 'Password cannot be blank' : null,
                                    controller: newpassword2Controller,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                    ),
                                    ),



                                    ],
                                    );
                                  },
                                ),
                          )
                      ),
                    ],
                  ),

                  SizedBox(height: 2),

                  //add friend
                  ExpansionTile(
                    title: Text('Add Friends ',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.exo2(
                          color: Color(0xFF8F8F8F),
                          fontWeight: FontWeight.w300,
                          fontSize: 18
                      ),
                    ),
                    leading: Image(height: 70, width: 65,
                      image: AssetImage('assets/images/user/add_friend.png'),
                    ),


                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Text('Big Bang'),
                      Text('Birth of the Sun'),
                      Text('Earth is Born'),
                      Text('Big Bang'),
                      Text('Birth of the Sun'),
                      Text('Earth is Born'),
                      Text('Big Bang'),
                      Text('Birth of the Sun'),
                      Text('Earth is Born'),
                      Text('Big Bang'),
                      Text('Birth of the Sun'),
                      Text('Earth is Born'),
                    ],
                  ),

                  SizedBox(height: 2),

                  //help
                  ExpansionTile(
                    title: Text('Help',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.exo2(
                          color: Color(0xFF8F8F8F),
                          fontWeight: FontWeight.w300,
                          fontSize: 18
                      ),
                    ),

                    leading: Image(height: 70, width: 65,
                      image: AssetImage('assets/images/user/help.png'),
                    ),

                    subtitle:

                    Text(
                      'Using ChatBot',
                      style: GoogleFonts.exo2(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 12
                      ),

                    ),

                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),

                    backgroundColor: Colors.white,
                    children: <Widget>[
                      HomePageDialogflow(),
                    ],
                  ),

                  SizedBox(height: 2.5),

                  Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),

                  SizedBox(height: 2.5),

                  GestureDetector(
                    onTap: () {
                      print("Tapped a onTap");

                      final snackBar = SnackBar(
                        content: Text('You need double click to logout .'),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            Scaffold.of(context).hideCurrentSnackBar();
                          },
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);






                    },

                    onDoubleTap: () async {
                      print("Tapped a onDoubleTap");

                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();

                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false,
                      );

//                      Navigator
//                          .of(context)
//                          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));


//                      final snackBar = SnackBar(
//                        content: Text('Hello! I am a onDoubleTap SnackBar!'),
//                        duration: Duration(seconds: 5),
//                        action: SnackBarAction(
//                          label: 'Undo',
//                          onPressed: () {
//                            // Some code to undo the change.
//                          },
//                        ),
//                      );
//                      Scaffold.of(context).showSnackBar(snackBar);


                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Image(height: 60, width: 60,
                                image: AssetImage('assets/images/user/exit.png'),
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(
                              child: Text('Sign out',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.exo2(
                                    color: Color(0xFF8F8F8F),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            flex: 5,
                          ),
                          Expanded(
                            child: Container(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),



                ],
              )
          ),
        )
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
                                  'Profile',
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
                                height: 35,
                                width: 35,
                                image: AssetImage(
                                  'assets/images/navbar/tools.png',
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

  void vider ()
  {
    passwordController.clear();
    newpasswordController.clear();
    newpassword2Controller.clear();
  }


  void _updateUser() async {
    Timer(Duration(seconds: 1), () {
      _btnController.stop();
      if(_key.currentState.validate())
      {
        print("Name :  "+nameController.text);
        print("Email : "+emailController.text);
        print("Phone : "+phonedController.text);

        var phone = int.parse(phonedController.text);

        databaseHelper2.UpdateUser(nameController.text,emailController.text,phone);
        _btnController.stop();
      }
    });
  }

  void _updateUserPassword(String oldPass) async {
    Timer(Duration(seconds: 1), () {
      _btnPasswordController.stop();
      if(_keyPassword.currentState.validate())
      {
        print("passwordController :  "+passwordController.text);
        print("newpasswordController : "+newpasswordController.text);
        print("newpassword2Controller : "+newpassword2Controller.text);


        if (newpasswordController.text == "" || newpassword2Controller.text == "" || passwordController.text == "") {
          print("wahed fehom mech m3aabi ");
        }
        else {
          if (newpassword2Controller.text != newpasswordController.text){
            print("1 et  2 mech kif kif");
            newpasswordController.clear();
            newpassword2Controller.clear();
            snack("paasword and confirmation must be the same", 3, Colors.red);

          }
          else {
            if (oldPass == passwordController.text){
              print("Mod de pass shih");
              databaseHelper2.UpdateUserPassword(newpasswordController.text);
              snack("Your password have been updated", 2, Colors.green);
              vider();

            }else{
              print("Mod de pass mech shih");
              snack("False current paasword", 3, Colors.red);
              passwordController.clear();

            }
          }



//        var phone = int.parse(phonedController.text);

          _btnPasswordController.stop();
        }
      }
    });
  }




}
