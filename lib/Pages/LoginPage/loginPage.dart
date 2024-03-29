import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_v1/Animation/FadeAnimation.dart';
import 'package:front_v1/Pages/HomePage/app_home_screen.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _key= GlobalKey<FormState>();

  bool _isLoading = false;
  bool t3ada = false;
  bool faregh = false;

  String _selectedId;
  bool _passwordVisible = false;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var fcm_token ;
  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
    _passwordVisible = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
// **********************************   the half
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/login/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/login/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/login/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/login/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(30.0),

                  child: Column(

                    children: <Widget>[


                      textSection(),

                      SizedBox(height: 30,),

                      buttonSection(),

                      SizedBox(height: 70,),

                      FadeAnimation(
                          1.5,

//                          Text(
//                            "Forgot Password?",
//                            style: TextStyle(
//                                color: Color.fromRGBO(143, 148, 251, 1)),
//                          )









                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'If you don"t have an account you can ',
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: ' Sign up',
                                    style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                                    recognizer: TapGestureRecognizer()
//                                      ..onTap = () => print('click')),
                                      ..onTap = () =>
                                          showDialog(
                                              context: context,
                                              child:  MyDialog(
                                                onValueChange: _onValueChange,
                                                initialValue: _selectedId,
                                              )
                                          )
                                ),

                              ],
                            ),
                          )













                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));

  }


  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print("token ===================>>>>> ");
      print(token);
      fcm_token = token;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }


  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();


  DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();

  void _doSomething() async {
        Timer(Duration(seconds: 1), () {

          _btnController.stop();

          if(_key.currentState.validate())
          {
            signIn(emailController.text, passwordController.text);
//            databaseHelper2.loginData(emailController.text, passwordController.text);
            _btnController.stop();
          }
    });
  }




  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;
    var response = await http.post(
        databaseHelper2.serverUrl+"/users/login",
//        "http://192.168.56.81:3000/api/users/login",
        body: data
    );
    log(response.statusCode);
    print('statusCode  :' + response.statusCode.toString());

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
//      print('jsonResponse  :' + jsonResponse);

      if (jsonResponse != null) {

        setState(() {
          t3ada = true;
          _isLoading = false;
        });

        sharedPreferences.setString("token", jsonResponse['token']);
        print(jsonResponse['User'].toString());


        print("fcm_token");
        print(fcm_token);


        databaseHelper2.UpdateUserFCM(
            fcm_token,
            jsonResponse['User'].toString()
        );
        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => AppHomeScreen()),
            (Route<dynamic> route) => false);
      }
    }
    else {
      var data = json.decode(response.body);

      if (data['message']=="Email Does not Exists"){
        await Fluttertoast.showToast(
            msg: "Email Does not Exists . ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0
        );
      }else if (data['message']=="Wrong Password") {
        await Fluttertoast.showToast(
            msg: "Wrong Password . ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0
        );
      }

      print(response.body);
    }
  }


//
//  DatabaseHelper databaseHelper = new DatabaseHelper();
//
//  signIn(String email, pass) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    Map data = {'username': email, 'password': pass};
//    var jsonResponse = null;
//    var response =
//
//
//        await http.post(databaseHelper.serverUrl+"/login", body: data);
//
//
//    if (response.statusCode == 200) {
//      jsonResponse = json.decode(response.body);
//      if (jsonResponse != null) {
//
//        setState(() {
//          t3ada = true;
//          _isLoading = false;
//        });
//        sharedPreferences.setString("token", jsonResponse['token']);
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(
//                builder: (BuildContext context) => AppHomeScreen()),
//            (Route<dynamic> route) => false);
//      }
//    }
//    else {
//      print(response.body);
//    }
//  }
//
//

  FadeAnimation buttonSection() {
    return FadeAnimation(
        2,
        Container(
          height: 50,
          child: AspectRatio(
            child: RoundedLoadingButton(
              color: HexColor('#54D3C2'),
              child: Text("Login", style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: _doSomething,
            ),
            aspectRatio: 8,
          ),
        ));
  }


  FadeAnimation textSection() {
    return FadeAnimation(
        1.8,
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10))
              ]),
          child : Form(
            key: _key,
            child: Column(
              children: <Widget>[
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
                          return"User name should be greater then 5";
                        }else
                          return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.grey[400]),
                        border: InputBorder.none,
                        hintText: "Email or Phone number",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) =>
                    value.isEmpty ? 'Password cannot be blank' : null,
                    controller: passwordController,
//                    obscureText: true,
                    obscureText: !_passwordVisible,//This will obscure text dynamically
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock, color: Colors.grey[400]),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),

                    ),
                  ),
                )
              ],
            ),
          )
        ));
  }

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

}



























class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  final _key= GlobalKey<FormState>();
  final _key2= GlobalKey<FormState>();
  Color myColor = Color(0xff00bfa5);

  bool _passwordVisible ;
  bool _password2Visible ;
  var status;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _password2Visible = false;

  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController password2Controller = new TextEditingController();

  final TextEditingController numTelController = new TextEditingController();

  DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();




//  void _doSomething() async {
//    if (_key2.currentState.validate()) {
//      databaseHelper2.registerData(
//        emailController.text, usernameController.text, passwordController.text, password2Controller.text,numTelController.text);
//
//
//
//    }else{
//
//
//      await Fluttertoast.showToast(
//          msg: "There field are empty , try again . ",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIosWeb: 3,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 10.0
//      );
//    }
//  }


  Widget build(BuildContext context) {
    return AlertDialog(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))
        ),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: SingleChildScrollView(
//        width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child:Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        key: _key2,
                        child: Column(
                            children: <Widget>[

                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Email can not be empty";
                                  }else
                                    return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.alternate_email, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                              ),


                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Username can not be empty";
                                  }else
                                    return null;
                                },
                                controller: usernameController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
                              ),




                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Password can not be empty";
                                  }else
                                    return null;
                                },
                                controller: passwordController,
                                obscureText: !_passwordVisible,//This will obscure text dynamically

                                decoration: InputDecoration(
                                    icon: Icon(Icons.power_input, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400]),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),

                                ),
                              ),



                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Confirm password can not be empty";
                                  }else
                                    return null;
                                },
                                controller: password2Controller,
                                obscureText: !_password2Visible,//This will obscure text dynamically

                                decoration: InputDecoration(
                                    icon: Icon(Icons.power_input, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Confirm password",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _password2Visible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _password2Visible = !_password2Visible;
                                      });
                                    },
                                  ),

                                ),
                              ),


                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return "  Phone number name can not be empty";
                                  }else
                                    return null;
                                },
                                controller: numTelController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Phone number",

                                    hintStyle: TextStyle(color: Colors.grey[400]),

                                ),
                                keyboardType: TextInputType.number,
                              ),



                            ]
                        ),
                      ),
                    ],
                  )
              ),
              InkWell(
                splashColor: myColor,
                child:
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: myColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0)),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  _doSomething();
//                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));



  }



  void _doSomething() async {
    Timer(Duration(seconds: 1), () {


      if(_key2.currentState.validate())
      {
        registerData(usernameController.text,emailController.text,  passwordController.text, password2Controller.text,numTelController.text);

//            databaseHelper2.loginData(emailController.text, passwordController.text);
      }
    });
  }





  registerData(String name ,String email , String password, String password2, String numTel) async{
      Map data = {'username': name,'email': email,  "password" : "$password", "password2" : "$password2", "numTel" : "$numTel"};

//    String myUrl = databaseHelper2.serverUrl+"/users/register";
    final response = await  http.post(databaseHelper2.serverUrl+"/users/register",


//        headers: {
//          'Accept':'application/json'
//        },


//        body: {
//          "email": "$email",
//          "username": "$name",
//          "password" : "$password",
//          "password2" : "$password2",
//          "numTel" : "$numTel"
//        }

        body: data

    ) ;
    status = response.body.contains('error');

//    print(' Status : ' + response.statusCode.toString());

    var statu = response.statusCode;

    print(' datas : ' + response.body);
    print(' message : ' + json.decode(response.body)['message']);
    print(' statu : ' + statu.toString());

    if (json.decode(response.body)['message']!="Account Create ! You can now Login"){
      await Fluttertoast.showToast(
          msg: "Email or Username Already Exists , try again . ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0
      );
    }
//    else
//
//      if (json.decode(response.body)['message']=="E11000"){
//      await Fluttertoast.showToast(
//          msg: "Username Already Exists , try again . ",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIosWeb: 3,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 10.0
//      );
//    }
      else{
      await Fluttertoast.showToast(
          msg: "Registration successfully completed :D ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 10.0
      );
    }


//    if(status){
//
//      await Fluttertoast.showToast(
//          msg: "there is somethings wrang :[ , try again . ",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIosWeb: 3,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 10.0
//      );
//
//      print('datas : ${datas["error"]}');
//
//    }
//    else{
//      print(' else status' + json.decode(response.body).toString());
//      print(datas['message']);
//
//      if (datas['message']=="Email Already Exists"){
//        await Fluttertoast.showToast(
//            msg: "Email or Username Already Exists , try again . ",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 3,
//            backgroundColor: Colors.red,
//            textColor: Colors.white,
//            fontSize: 10.0
//        );
//      }
//
//      else{
//        await Fluttertoast.showToast(
//            msg: "  Registration successfully completed :D  . ",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 5,
//            backgroundColor: Colors.green,
//            textColor: Colors.white,
//            fontSize: 10.0
//        );
//      }
//
//
////      print('data : ${data["token"]}');
////      _save(data["token"]);
//
//    }



  }


}
