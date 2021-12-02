//import 'dart:html';

import 'dart:io';
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_v1/Models/Device.dart';
import 'package:front_v1/Models/User.dart';
import 'package:front_v1/Pages/HomePage/app_home_screen.dart';
import 'package:front_v1/src/DeviceData.dart';
import 'package:front_v1/src/locations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:developer' ;
import 'package:flutter/foundation.dart';


class DatabaseHelper{

//  String serverUrl = "http://192.168.56.125:8000/api";

  String serverUrl = "http://192.168.56.7:8000/api";
//    String serverUrl = "http://192.168.1.11:8000/api";


  var status = false ;
  var token ;

  loginData(String email , String password) async{

    String myUrl = "$serverUrl/login";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "username": "$email",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');
    var data = json.decode(response.body);

    log('Data : $data');

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }

  registerData(String name ,String email , String password, String password2) async{

    String myUrl = "$serverUrl/register";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "username": "$name",
          "email": "$email",
          "password" : "$password",
          "password2" : "$password2"
        }
    ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }
    else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }




  /* TEST */
//  Future<Stream<Devices>> getDevices() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key ) ?? 0;
//    var headerss = {
//      'Accept':'application/json',
//      'Authorization' : 'token $value'
//    };
//    final String myUrl = "$serverUrl/device/All_Device";
//    final client = new http.Client();
//    final streamedRest = await client.send(
//        http.Request('get',Uri.parse(myUrl)));
//
//    return streamedRest.stream
//        .transform(utf8.decoder)
//        .transform(json.decoder)
//        .expand((data) => (data as List))
//        .map((data) => Devices.fromJSON(data));
//    }
  /* TEST */





  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/Get_All_Device_By_User";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return json.decode(response.body);
  }



  Future<List> getDataByDevice(String slug) async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/All_data_by_device/$slug";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return  json.decode(response.body);
  }


  Future<List> getDatahumains() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/Get_All_devices_By_User_humains";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return json.decode(response.body);
  }




  Future<LocationsDevices> getYourDevices(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
//  const googleLocationsURL = 'https://about.google/static/data/locations.json';
    String googleLocationsURL = "$serverUrl/device/All_data_by_device/$slug";
    final response = await http.get(googleLocationsURL ,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    if (response.statusCode == 200) {
      return LocationsDevices.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
              ' ${response.reasonPhrase}',
          uri: Uri.parse(googleLocationsURL));
    }
  }


  void addData(String name , String category , String ref) async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/create";
    await http.post(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        },
        body: {
          "title": "$name",
          "category" : "$category",
          "ref" : "$ref",
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
  void editDevice(String title,String category , String ref , String slug) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/$slug/update";
    await http.put(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        },
        body: {
          "title": "$title",
          "category" : "$category",
          "ref" : "$ref",
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
  void editFavorit(String title,String category , String ref , String slug , bool favorit) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/$slug/update";
    await http.put(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        },
        body: {
          "title": "$title",
          "category" : "$category",
          "ref" : "$ref",
          "favorit" : "$favorit",
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
  void deleteDevice(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/$slug/delete";
    await http.delete(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        } ).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }
  Future<List> getFavoritDevices() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    String myUrl = "$serverUrl/device/Get_All_Favorit_devices";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return json.decode(response.body);
  }



  Future<Device> getFavoritDevices2() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/Get_All_Favorit_devices";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    if (response.statusCode == 200) {
      return Device.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
//  return json.decode(response.body);


  }


  Future<List> getUserDetails() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/user";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return json.decode(response.body);
  }
  Future<List> count_devices_By_User() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/Get_count_devices_By_User";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    return json.decode(response.body);
  }


  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/user";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      return User.fromJson(json.decode(response.body));
    } else {
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


//  Future<Devices_obj> getAllData() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key ) ?? 0;
//
//    String myUrl = "$serverUrl/device/All_data_All_devices";
//    http.Response response = await http.get(myUrl,
//        headers: {
//          'Accept':'application/json',
//          'Authorization' : 'token $value'
//        });
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      return Devices_obj.fromJson(json.decode(response.body));
//    } else {
//      // then throw an exception.
//      throw Exception('Failed to load album');
//    }
//  }

  Future<List> getAllData2() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/device/All_data_All_devices";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });

    return json.decode(response.body);
  }

//  Future<DevicesDataLocations> getAllDataForAllDevices() async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key ) ?? 0;
//    String googleLocationsURL = "$serverUrl/device/All_data_All_devices";
//    final response = await http.get(googleLocationsURL ,
//        headers: {
//          'Accept':'application/json',
//          'Authorization' : 'token $value'
//        });
//    if (response.statusCode == 200) {
//      return DevicesDataLocations.fromJson(json.decode(response.body));
//    } else {
//      throw HttpException(
//          'Unexpected status code ${response.statusCode}:'
//              ' ${response.reasonPhrase}',
//          uri: Uri.parse(googleLocationsURL));
//    }
//  }
}



class DatabaseHelper2 {

  String serverUrl = "http://51.210.182.172:3003/api";
//  String serverUrl = "http://192.168.1.10:3000/api";
//  String serverUrl = "http://192.168.56.247:3000/api";



  var status = false;

  var token;

  loginData(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;

    String myUrl = "$serverUrl/users/login";
    var  response = await http.post(myUrl,
        body: {
          "email": "$email",
          "password": "$password"
        });

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
      }
    }
    else {
      print(response.body);
    }

    log('email : $email');
    log('password : $password');

//    status = response.body.contains('error');
    var data = json.decode(response.body);

    log('Data : $data');

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  registerData(String name ,String email , String password, String password2, String numTel) async{

    String myUrl = "$serverUrl/users/register";
    final response = await  http.post(myUrl,
        headers: {
          'Accept':'application/json'
        },
        body: {
          "email": "$email",
          "username": "$name",
          "password" : "$password",
          "password2" : "$password2",
          "numTel" : "$numTel"
        }
    ) ;
    status = response.body.contains('error');


//    print(' response.body 9bal if' + json.decode(response.body).toString());
    print(' Status : ' + response.statusCode.toString());

//    print(' Status2 : ' + status.toString());

    var data = json.decode(response.body);

    if(status){
//      print('data : ${data["error"]}');

      await Fluttertoast.showToast(
          msg: "there is somethings wrang :[ , try again . ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 10.0
      );

      print('data : ${data["error"]}');

    }
    else{
      print(' else status' + json.decode(response.body).toString());
      print(data['message']);

      if (data['message']=="Email Already Exists"){
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

      else{
        await Fluttertoast.showToast(
            msg: "  Registration successfully completed :D  . ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 10.0
        );
      }


//      print('data : ${data["token"]}');
//      _save(data["token"]);

    }

  }

  void UpdateUserFCM(String fcm_token,String id) async {
//    final prefs = await SharedPreferences.getInstance();
//    final key = 'token';
//    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/users/UpdateUserFCM/$id";
    await http.put(myUrl,
//        headers: {
//          'Accept': 'application/json',
//          'Authorization': 'token $value'
//        },
        body: {
          "fcm_token": "$fcm_token",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }



  Future<List> AllDeviceByUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myUrl = "$serverUrl/Devices/All_device_by_user";
    http.Response response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }

  Future<Device> LastDeviceByUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myUrl = "$serverUrl/Devices/Last_Device";
    http.Response response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });

//    if (response.statusCode == 200) {

    return Device.fromJson(json.decode(response.body));
//      return json.decode(response.body);


//    }else{
//      print(response.body);
//    }

//      return json.decode(response.body);
  }

  Future<List> getDeviceByID(String ID) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/$ID";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }

  Future<List> getDataOfDeviceByID(String ID) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/dataof/$ID";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }

  Future<LocationsAndDataOfDevice> getYourDevices(String ID) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String googleLocationsURL = "$serverUrl/Devices/$ID";
    final response = await http.get(googleLocationsURL ,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'token $value'
        });
    if (response.statusCode == 200) {
      return LocationsAndDataOfDevice.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
          'Unexpected status code ${response.statusCode}:'
              ' ${response.reasonPhrase}',
          uri: Uri.parse(googleLocationsURL));
    }
  }

  Future<List> getDeviceByREF(String ref) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/GetByRef/$ref";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }




  void AddDevice(String title, String ref, String category) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/AddDevice";
    await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "title": "$title",
          "ref": "$ref",
          "category": "$category",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void UpdateDevice(String title, String ref,String category,  String ID) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/UpdateDevice/$ID";
    await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "title": "$title",
          "ref": "$ref",
          "category": "$category",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }




  void RemoveDevice(String ID) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/RemoveDevice/$ID";
    await http.delete(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List> getFavorit() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    String myUrl = "$serverUrl/Devices/GetFavorit";
    http.Response response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }

  void UpdateFavorit(String ID, bool favorit) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/UpdateFavoritDevice/$ID";
    await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "favorit": "$favorit",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void Updatetraking(String ID, bool traking) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Devices/traking/$ID";
    await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "traking": "$traking",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<User> Profile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/users/Profile";
    http.Response response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      return User.fromJson(json.decode(response.body));
    } else {
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void UpdateUser( String username,String email,int numTel) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/users/UpdateUser";
    await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "username": "$username",
          "email": "$email",
          "numTel": "$numTel",

        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void UpdateUserPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/users/UpdatePassword";
    await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        },
        body: {
          "password": "$password",
        }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  Future<List> count_devices_By_User() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/device/Get_count_devices_By_User";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'token $value'
        });
    return json.decode(response.body);
  }



  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

}
