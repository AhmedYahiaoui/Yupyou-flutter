//import 'dart:async';
//import 'dart:ui';
//
//import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
//import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:front_v1/Pages/Dashboard/dashscreen.dart';
//import 'package:front_v1/Pages/DevicePage/DeviceScreen.dart';
//import 'package:front_v1/Pages/HomePage/app_home_screen.dart';
//import 'package:front_v1/Service/DatabaseHelper.dart';
//import 'package:front_v1/Theme/app_theme.dart';
//import 'package:front_v1/main.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart';
//import 'package:intl/intl.dart';
//import 'package:front_v1/src/locations.dart' as locations;
//
//import 'package:sliding_up_panel/sliding_up_panel.dart';
//import 'dart:math' as math;
//
//class DeviceShowDetails extends StatefulWidget {
//  List list;
//  int index;
//  String slugg;
//  DeviceShowDetails({this.index, this.list, this.slugg});
//  @override
//  _PlantScreenState createState() => _PlantScreenState();
//}
//
//class _PlantScreenState extends State<DeviceShowDetails>
//    with TickerProviderStateMixin {
//  AnimationController animationController;
//  String _selectedId;
//
//  Widget tabBody = Container(
//    color: AppTheme.background,
//  );
//
////  DatabaseHelper databaseHelper = new DatabaseHelper();
//  DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();
//
//  get slugg => widget.slugg;
//
//  IconData iconchoice() {
//    var grade = widget.list[widget.index]['category'];
//    switch (grade) {
//      case "human":
//        {
//          return Icons.person_outline;
//        }
//        break;
//      case "animal":
//        {
//          return Icons.adb;
//        }
//        break;
//      case "car":
//        {
//          return Icons.local_shipping;
//        }
//        break;
//      case "object":
//        {
//          return Icons.child_friendly;
//        }
//        break;
//    }
//  }
//
//  IconData iconFavorit() {
//    if (widget.list[widget.index]['favorit'] == true) {
//      return Icons.favorite;
//    } else {
//      return Icons.favorite_border;
//    }
//    ;
//  }
//
//  String imagechoice() {
//    var grade = widget.list[widget.index]['category'];
//    switch (grade) {
//      case "human":
//        {
//          return 'assets/images/plant2.png';
//        }
//        break;
//      case "animal":
//        {
//          return 'assets/images/plant0.png';
//        }
//        break;
//      case "cars":
//        {
//          return 'assets/images/plant2.png';
//        }
//        break;
//      case "objects":
//        {
//          return 'assets/images/plant1.png';
//        }
//        break;
//    }
//    print("slugg");
//    print(slugg);
//  }
//
////  ScrollController _controller;
//
//  BitmapDescriptor pinLocationIcon;
//  BitmapDescriptor PIN;
//  BitmapDescriptor pinLastLocationIcon;
//
//  @override
//  void initState() {
////    _controller = ScrollController();
//    animationController = AnimationController(
//        duration: const Duration(milliseconds: 600), vsync: this);
//    tabBody = DashScreen(animationController: animationController);
//
//    super.initState();
//    setCustomMapPin();
//    setCustomMapLastPin();
//    isPressed = widget.list[widget.index]['favorit'];
//  }
//
//  void setCustomMapPin() async {
//    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/location.png');
//  }
//
//  void setCustomMapLastPin() async {
//    pinLastLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/location-pin.png');
//  }
//
//  bool isPressed;
//  _pressed() {
//    var newVal = true;
//    if (isPressed) {
//      databaseHelper.editFavorit(
//          widget.list[widget.index]['title'],
//          widget.list[widget.index]['category'],
//          widget.list[widget.index]['ref'],
//          slugg,
//          false);
//      newVal = false;
//    } else {
//      databaseHelper.editFavorit(
//          widget.list[widget.index]['title'],
//          widget.list[widget.index]['category'],
//          widget.list[widget.index]['ref'],
//          slugg,
//          true);
//      newVal = true;
//    }
//
//    // This function is required for changing the state.
//    // Whenever this function is called it refresh the page with new value
//    setState(() {
//      isPressed = newVal;
//    });
//  }
//
//  final Map<String, Marker> _markers = {};
//  final LatLng _center = const LatLng(32.1139182, 9.5956896);
//
//  void confirm (){
//    AlertDialog alertDialog =  AlertDialog(
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
//      backgroundColor: Colors.white,
//
//      content:  Text(" You want to delete '${widget.list[widget.index]['title']}'"),
//      actions: <Widget>[
//
//         RaisedButton(
//          child:  Text("CANCEL",style:  TextStyle(color: Colors.green)),
//          color: Colors.white,
//          onPressed: ()=> Navigator.pop(context),
//        ),
//
//        RaisedButton(
//          child:  Text("OK DELETE!",style:  TextStyle(color: Colors.red)),
//          color: Colors.white,
//          onPressed: (){
//            _delete();
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => AppHomeScreen()));
//          },
//        ),
//      ],
//    );
//
//    showDialog(context: context, child: alertDialog);
//  }
//
//
//
//
//  Future<void> _onMapCreated(GoogleMapController controller) async {
////    controller.setMapStyle(Utils.mapStyles);
//    setState(() {
//      _markers.clear();
//      int i = widget.list[widget.index]["datas"].length-1;
//      print("********************** long list w i = " + i.toString());
//
//      for (final Deviceslocation in widget.list[widget.index]["datas"]) {
//        if (i == widget.list[widget.index]["datas"].length-1) {
//          PIN = pinLastLocationIcon;
//        } else {
//          PIN = pinLocationIcon;
//        }
//        final marker = Marker(
//            markerId: MarkerId(Deviceslocation["time"].toString()),
//            position: LatLng(Deviceslocation["LAT"], Deviceslocation["LNG"]),
//            infoWindow: InfoWindow(
//              title: "La " + i.toString() + "éme Place  * ",
//              snippet: Deviceslocation["LAT"].toString() +
//                  " | " +
//                  Deviceslocation["LNG"].toString(),
//            ),
//            icon: PIN);
//        _markers[Deviceslocation["time"].toString()] = marker;
//        i--;
//      }
//    });
//  }
//
//
//
//
//
//
////  Future<void> _onMapCreated(GoogleMapController controller) async {
//////    controller.setMapStyle(Utils.mapStyles);
//////    final googleOffices = await databaseHelper.getYourDevices(slugg);
////    final googleOffices = await databaseHelper.getYourDevices(slugg);
////    setState(() {
////      _markers.clear();
////      int i = googleOffices.Deviceslocations.length;
////      for (final Deviceslocation in googleOffices.Deviceslocations) {
////        // ignore: unrelated_type_equality_checks
////        if (i == googleOffices.Deviceslocations.length) {
////          PIN = pinLastLocationIcon;
////        } else {
////          PIN = pinLocationIcon;
////        }
////
////        print("googleOffices.Deviceslocations.last");
////        print(googleOffices.Deviceslocations.last.date_updated);
////        final marker = Marker(
////            markerId: MarkerId(Deviceslocation.id.toString()),
////            position: LatLng(Deviceslocation.lat, Deviceslocation.lng),
////            infoWindow: InfoWindow(
////              title: "La " + i.toString() + "éme Place  * ",
////              snippet: Deviceslocation.lat.toString() +
////                  " | " +
////                  Deviceslocation.lng.toString(),
////            ),
////            icon: PIN);
////        _markers[Deviceslocation.id.toString()] = marker;
////        i--;
////      }
////      print(googleOffices.Deviceslocations.length);
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    BorderRadiusGeometry radius = BorderRadius.only(
//      topLeft: Radius.circular(24.0),
//      topRight: Radius.circular(24.0),
//    );
//
//    return WillPopScope(
//        onWillPop: () async => false,
//        child: MaterialApp(
//          debugShowCheckedModeBanner: false,
//          home: Scaffold(
//              body: SafeArea(
//                  child: Column(children: <Widget>[
//                    Container(
//                      height: MediaQuery.of(context).size.height - 24,
//                      width: MediaQuery.of(context).size.width,
//                      child: Stack(children: <Widget>[
//                        GoogleMap(
//                  onMapCreated: _onMapCreated,
//                  mapType: MapType.normal,
//                  compassEnabled: true,
//                  zoomGesturesEnabled: true,
//                  myLocationEnabled: true,
//                  rotateGesturesEnabled: true,
//                  scrollGesturesEnabled: true,
//                  tiltGesturesEnabled: false,
//                  initialCameraPosition: CameraPosition(
//                    target: _center,
//                    zoom: 6.0,
//                  ),
//                  markers: _markers.values.toSet(),
//                ),
//                        Container(
//                  margin: EdgeInsets.only(
//                      top: MediaQuery.of(context).size.width * 0.05,
//
////                      MediaQuery.of(context).size.height -
////                          MediaQuery.of(context).size.height + 30
//
//                      right: 20,
//                      left: 0),
//                  width: MediaQuery.of(context).size.width * 0.2,
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.only(
//                        bottomRight: const Radius.circular(30.0),
//                        topRight: const Radius.circular(30.0),
//                      ),
//                      boxShadow: []),
//                  child: Row(
//                    children: <Widget>[
//                      SizedBox(
//                        width: 20,
//                      ),
//                      GestureDetector(
//                        onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => AppHomeScreen()));
////                      Navigator.pop(context);
//                        },
//                        child: Icon(
//                          Icons.arrow_back,
//                          size: 40.0,
//                          color: AppTheme.nearlyDarkGeen,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                        // CARD VIEW  *********************************************************
//                        Container(
//                  margin: EdgeInsets.only(
//                      top: MediaQuery.of(context).size.height * 0.61,
//                      right: 0,
//                      left: 0),
//                  height: MediaQuery.of(context).size.width * 0.55 ,
//                  width: MediaQuery.of(context).size.width / 1.4,
//
//
//
//
//
//
////                  margin: EdgeInsets.only(
////                      top: MediaQuery.of(context).size.height - 320,
////                      right: 0,
////                      left: 0),
////                  height: 230,
////                  width: MediaQuery.of(context).size.width / 1.4,
//
//
//
//
//
//
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.only(
//                        bottomRight: const Radius.circular(30.0),
//                        topRight: const Radius.circular(30.0),
//                      ),
//                      boxShadow: [
//                        BoxShadow(
//                            color: Colors.black12.withOpacity(.1),
//                            blurRadius: 2,
//                            spreadRadius: 2),
//                      ]),
//                  child: Column(
//                    children: <Widget>[
//                      SizedBox(
//                        height: 15,
//                      ),
//                      Text(
//                        '${DateFormat("MMM dd, yyyy").format(DateTime.now())}',
//                        style: TextStyle(
//                          color: AppTheme.nearlyDarkGeen,
//                          fontSize: 20,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          Column(
//                            children: <Widget>[
//                              Text(
//                                '${widget.list[widget.index]['title'].toUpperCase()}',
//                                style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 22,
//                                    fontStyle: FontStyle.normal,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              Text(
//                                'NAME',
//                                style: TextStyle(
//                                    color: Colors.grey[400], fontSize: 15),
//                              ),
//                            ],
//                          ),
//                          SizedBox(
//                            width: 35,
//                          ),
//                          Container(
//                            height: 12,
//                            child: VerticalDivider(
//                              width: 2,
//                              color: Colors.black,
//                            ),
//                          ),
//                          SizedBox(
//                            width: 35,
//                          ),
//                          Container(
//                            height: 60,
//                            width: 60,
//                            decoration: BoxDecoration(
//                              border: Border.all(
//                                color: Colors.grey[400],
//                              ),
//                              borderRadius: BorderRadius.circular(80.0),
//                            ),
//                            child: Icon(iconchoice(),
//                                size: 35, color: AppTheme.nearlyDarkGeen),
//                          ),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          Column(
//                            children: <Widget>[
//                              Text(
//                                '${widget.list[widget.index]['category'].toUpperCase()}',
//                                style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 22,
//                                    fontStyle: FontStyle.normal,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              Text(
//                                'CATEGORY',
//                                style: TextStyle(
//                                    color: Colors.grey[400], fontSize: 15),
//                              ),
//                            ],
//                          ),
//                          SizedBox(
//                            width: 60,
//                          ),
//                          Column(
//                            children: <Widget>[
//                              SizedBox(
//                                height: 50.0,
//                                width: 50.0,
//                                child: IconButton(
//                                  icon: Icon(isPressed
//                                      ? Icons.favorite
//                                      : Icons.favorite_border),
//                                  onPressed: () => _pressed(),
//                                  iconSize: 40.0,
//                                  color: Colors.pink,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//
//
//                        Container(
//                  margin: EdgeInsets.only(
//                      top: MediaQuery.of(context).size.height - 320,
//                      right: 0,
//                      left: MediaQuery.of(context).size.width -
//                          MediaQuery.of(context).size.width / 4.8),
//                  child: Column(
//                    children: <Widget>[
//
//                      Container(
//                          height: MediaQuery.of(context).size.width / 6.5,
//                          width: MediaQuery.of(context).size.width / 6.5,
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.only(
//                                bottomRight: const Radius.circular(20.0),
//                                topRight: const Radius.circular(20.0),
//                                bottomLeft: const Radius.circular(20.0),
//                                topLeft: const Radius.circular(20),
//                              ),
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.black12.withOpacity(.1),
//                                    blurRadius: 2,
//                                    spreadRadius: 2),
//                              ]),
//                        child: GestureDetector(
//                          onTap: () {
//                            print("onTap map");
//                            Fluttertoast.showToast(
//                                msg: "  Make a long press  ",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.BOTTOM,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: AppTheme.nearlyDarkGeen,
//                                textColor: Colors.white,
//                                fontSize: 20.0
//                            );
//                          },
//                          onLongPress: (){
//                            print("onLongPress map");
//                            confirm ();
//                          },
//                          child:Icon(Icons.map, size: 34 ,color: AppTheme.nearlyDarkGeen),
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//
//                      Container(
//                        height: MediaQuery.of(context).size.width / 6.5,
//                        width: MediaQuery.of(context).size.width / 6.5,
//                        decoration: BoxDecoration(
//                            color: Colors.green,
//                            borderRadius: BorderRadius.only(
//                              bottomRight: const Radius.circular(20.0),
//                              topRight: const Radius.circular(20.0),
//                              bottomLeft: const Radius.circular(20.0),
//                              topLeft: const Radius.circular(20),
//                            ),
//                            boxShadow: [
//                              BoxShadow(
//                                  color: Colors.black12.withOpacity(.1),
//                                  blurRadius: 2,
//                                  spreadRadius: 2),
//                            ]),
//
//
//                        child: GestureDetector(
//                          onTap: () {
//                            print("onTap");
//                            Fluttertoast.showToast(
//                                msg: "  Make a long press  ",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.BOTTOM,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: Colors.green,
//                                textColor: Colors.white,
//                                fontSize: 20.0
//                            );
//                          },
//                          onLongPress: (){
//                            print("onLongPress");
//                            print(widget.list[widget.index]['ref'].toString());
//
////                            confirm ();
//                            showDialog(
//                                context: context,
//                                child:
//
//
//                                MyDialog(
//                                  onValueChange: _onValueChange,
//                                  initialValue: _selectedId,
//                                  slugg: slugg,
//                                  title: widget.list[widget.index]['title'],
//                                  ref: widget.list[widget.index]['ref'],
//                                  category: widget.list[widget.index]['category'],
//                                ));
//                          },
//                          child:Icon(Icons.settings, size: 34 ,color: Colors.white),
//                        ),
//
//
//
//
//
//
//
////                        GestureDetector(
////                          onTap: () {
////                            print("onTap");
////                            Fluttertoast.showToast(
////                                msg: "  Make a long press  ",
////                                toastLength: Toast.LENGTH_SHORT,
////                                gravity: ToastGravity.BOTTOM,
////                                timeInSecForIosWeb: 1,
////                                backgroundColor: Colors.green,
////                                textColor: Colors.white,
////                                fontSize: 20.0
////                            );
////                          },
////                          onLongPress: (){
////                            print("onLongPress");
//////                            confirm ();
////                            showDialog(
////                                context: context,
////                                child:
////
////
////                                MyDialog(
////                                  onValueChange: _onValueChange,
////                                  initialValue: _selectedId,
////                                  slugg: slugg,
////                                  title: widget.list[widget.index]['title'],
////                                  ref: widget.list[widget.index]['ref'],
////                                ));
////                          },
////                          child:Icon(Icons.settings, size: 34 ,color: Colors.white),
////                        ),
//
//
//
//
//
//
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//
//                      Container(
//                        height: MediaQuery.of(context).size.width / 6.5,
//                        width: MediaQuery.of(context).size.width / 6.5,
//                        decoration: BoxDecoration(
//                            color: Colors.red,
//                            borderRadius: BorderRadius.only(
//                              bottomRight: const Radius.circular(20.0),
//                              topRight: const Radius.circular(20.0),
//                              bottomLeft: const Radius.circular(20.0),
//                              topLeft: const Radius.circular(20),
//                            ),
//                            boxShadow: [
//                              BoxShadow(
//                                  color: Colors.black12.withOpacity(.1),
//                                  blurRadius: 2,
//                                  spreadRadius: 2),
//                            ]),
//
//                        child: GestureDetector(
//                          onTap: () {
//                            print("onTap");
//                            Fluttertoast.showToast(
//                                msg: "  Make a long press  ",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.BOTTOM,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: Colors.red,
//                                textColor: Colors.white,
//                                fontSize: 20.0
//                            );
//                          },
//                          onLongPress: (){
//                            print("onLongPress");
//                            confirm ();
//                          },
//                          child:Icon(Icons.delete, size: 34 ,color: Colors.white),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//
//
//                SlidingUpPanel(
//                  maxHeight: MediaQuery.of(context).size.height * 0.8,
//                  minHeight: MediaQuery.of(context).size.width * 0.13,
//                  panel: Center(
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(
//                          height: 20,
//                        ),
//                        Container(
//                          decoration: BoxDecoration(
//                              border: Border.all(
//                                color: AppTheme.nearlyDarkGeen,
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20))),
//                          height: 5,
//                          width: MediaQuery.of(context).size.width / 8,
//                          child: Divider(
//                              color: AppTheme.nearlyDarkGeen, thickness: 3),
//                        ),
//                        SizedBox(
//                          height: 15,
//                        ),
////                        Container(
////                          height: MediaQuery.of(context).size.height / 1.45,
////                          child: FutureBuilder(
////                            future: databaseHelper2.getDeviceByREF(slugg),
////                            builder: (context, snapshot) {
////                              if (snapshot.hasError) print(snapshot.error);
////                              return snapshot.hasData
////                                  ? ItemList(list: snapshot.data)
////                                  : Center(
////                                      child: CircularProgressIndicator(
////                                        valueColor:
////                                            AlwaysStoppedAnimation<Color>(
////                                                AppTheme.nearlyDarkGeen),
////                                      ),
////                              );
////                            },
////                          ),
////                        ),
//
//
//                        Container(
//                          height: MediaQuery.of(context).size.height / 1.45,
//                          child:
////                              Text("data")
//
//                          FutureBuilder(
//                            future: databaseHelper2.getDeviceByREF(slugg),
//                            builder: (context, snapshot) {
//                              if (snapshot.hasError) print(snapshot.error);
//                              return snapshot.hasData
//                                  ? ItemList(list: snapshot.data)
//                                  : Center(
//                                      child: CircularProgressIndicator(
//                                        valueColor:
//                                            AlwaysStoppedAnimation<Color>(
//                                                AppTheme.nearlyDarkGeen),
//                                      ),
//                              );
//                            },
//                          ),
//
//
//
//                          ),
//
//
//
//                      ],
//                    ),
//                  ),
//                  collapsed: Container(
//                    decoration: BoxDecoration(
//                        color: Colors.white, borderRadius: radius),
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Container(
//                          decoration: BoxDecoration(
//                              border: Border.all(
//                                color: AppTheme.nearlyDarkGeen,
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20))),
//                          height: 5,
//                          width: MediaQuery.of(context).size.width / 8,
//                          child: Divider(
//                              color: AppTheme.nearlyDarkGeen, thickness: 3),
//                        ),
//                      ],
//                    ),
//                  ),
//                  borderRadius: radius,
//                ),
//              ]),
//            ),
//          ]))),
//        ));
//  }
//
//  void _onValueChange(String value) {
//    setState(() {
//      _selectedId = value;
//    });
//  }
//  void _delete() async {
//    databaseHelper.deleteDevice(slugg);
//  }
//}
//
//class Utils {
//  static String mapStyles = '''[
//  {
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#f5f5f5"
//      }
//    ]
//  },
//  {
//    "elementType": "labels.icon",
//    "stylers": [
//      {
//        "visibility": "off"
//      }
//    ]
//  },
//  {
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#616161"
//      }
//    ]
//  },
//  {
//    "elementType": "labels.text.stroke",
//    "stylers": [
//      {
//        "color": "#f5f5f5"
//      }
//    ]
//  },
//  {
//    "featureType": "administrative.land_parcel",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#bdbdbd"
//      }
//    ]
//  },
//  {
//    "featureType": "poi",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#eeeeee"
//      }
//    ]
//  },
//  {
//    "featureType": "poi",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#757575"
//      }
//    ]
//  },
//  {
//    "featureType": "poi.park",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#e5e5e5"
//      }
//    ]
//  },
//  {
//    "featureType": "poi.park",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#9e9e9e"
//      }
//    ]
//  },
//  {
//    "featureType": "road",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#ffffff"
//      }
//    ]
//  },
//  {
//    "featureType": "road.arterial",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#757575"
//      }
//    ]
//  },
//  {
//    "featureType": "road.highway",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#dadada"
//      }
//    ]
//  },
//  {
//    "featureType": "road.highway",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#616161"
//      }
//    ]
//  },
//  {
//    "featureType": "road.local",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#9e9e9e"
//      }
//    ]
//  },
//  {
//    "featureType": "transit.line",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#e5e5e5"
//      }
//    ]
//  },
//  {
//    "featureType": "transit.station",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#eeeeee"
//      }
//    ]
//  },
//  {
//    "featureType": "water",
//    "elementType": "geometry",
//    "stylers": [
//      {
//        "color": "#c9c9c9"
//      }
//    ]
//  },
//  {
//    "featureType": "water",
//    "elementType": "labels.text.fill",
//    "stylers": [
//      {
//        "color": "#9e9e9e"
//      }
//    ]
//  }
//]''';
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//class ItemList extends StatelessWidget {
//  List list;
//  ItemList({this.list});
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return ListView.builder(
//        itemCount: list == null ? 0 : list.length,
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        padding: const EdgeInsets.all(10),
//        itemBuilder: (context, i) {
//
////          DateTime updatedate = DateTime.parse(list[i]['date_updated'].toString());
//
//
//          String t = list[i]['time'];
//          var int2 = int.tryParse(t);
//          var updatedate = DateTime.fromMillisecondsSinceEpoch(int2);
////          var formattedDate = DateFormat.yMMMMEEEEd().format(date);
//
//
//          print(
//              '****************************************************************************************************************' + updatedate.toString());
//
//          DateTime updatedate2;
//          Duration diffDt;
//
//          if (i >= 0 && i < list.length - 1) {
//            updatedate2 =
//                DateTime.parse(list[i]['time'].toString());
//          } else {
//            updatedate2 = DateTime.parse(list[i]['time'].toString());
//          };
//
//
//
//
//          if (i == 0) {
//            diffDt = DateTime.now().difference(updatedate);
//            print(' diffDt ' + diffDt.inMinutes.toString());
//          }
//
//          if (i > 0 && i < list.length - 1) {
//            diffDt = DateTime.parse(list[i]['time'].toString())
//                .difference(
//                    DateTime.parse(list[i + 1]['time'].toString()));
//          } else {
//            diffDt = DateTime.parse(list[i]['time'].toString())
//                .difference(updatedate);
//          };
//
//
//
//          Icon iconchoic() {
//            if (list[i]['batterie'] >= 0 && list[i]['batterie'] < 30) {
//              return Icon(
//                Icons.battery_alert,
////                    size: 200,
//                color: Colors.red,
//              );
//              ;
//            } else if (list[i]['batterie'] >= 30 && list[i]['batterie'] < 60) {
//              return Icon(
//                Icons.battery_full,
////                    size: 200,
//                color: Colors.yellow,
//              );
//              ;
//            } else {
//              return Icon(
//                Icons.battery_charging_full,
////                    size: 200,
//                color: Colors.green,
//              );
//            }};
//
//
//
//          return Card(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(25.0),
//              side: BorderSide(
//                color: Colors.grey,
//                width: 0.5,
//              ),
//            ),
//            margin: EdgeInsets.all(12),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Text('Stay here :',
//                        style: TextStyle(
//                          fontSize: 15,
//                          color: Colors.grey[400],
//                        )),
//                    Row(children: <Widget>[
//                      Text(
//                        'Travel time : ',
//                        style: TextStyle(
//                          fontSize: 12,
//                          color: Colors.grey[400],
//                        ),
//                      ),
//                      Text(list[i]['LAT'].toString() +
//                          '\n' +
//                          list[i]['LNG'].toString()),
//                    ]),
//                    Text(
//                      updatedate.hour.toString() +
//                          ':' +
//                          updatedate.minute.toString(),
//                      style: TextStyle(
//                        fontSize: 15,
//                        color: AppTheme.nearlyDarkGeen,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Row(children: <Widget>[
//                      Text(
//                        diffDt.inMinutes.toString(),
//                        style: TextStyle(
//                          fontSize: 50,
//                          color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                      Text('min'),
//                    ]),
//                    SizedBox(
//                      width: 20,
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Transform.rotate(
//                          angle: 90 * math.pi / 180,
//                          child: iconchoic(),
//                        ),
//                        Text(
//                          list[i]['batterie'].toString() + ' %',
//                          style: TextStyle(
//                            fontSize: 14,
//                            color: Colors.grey[400],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Column(
//                  children: <Widget>[
//                    Row(
//                      children: [
//                        SizedBox(
//                          width: 20,
//                        ),
//                        Icon(
//                          Icons.fiber_manual_record,
//                          color: Colors.greenAccent,
//                          size: 15.0,
//                        ),
//                        Text(
//                          '   ' +
//                              DateFormat.MMMMd().format(updatedate) +
//                              ' ' +
//                              ', ' +
//                              updatedate.hour.toString() +
//                              ':' +
//                              updatedate.minute.toString(),
//                          style: TextStyle(
//                            fontSize: 14,
//                            color: Colors.grey[400],
//                          ),
//                        ),
//                      ],
//                    ),
//                    SizedBox(
//                      height: 2,
//                    ),
//                    Row(
//                      children: [
//                        SizedBox(
//                          width: 25,
//                        ),
//                        Column(
//                          children: <Widget>[
//                            Icon(
//                              Icons.fiber_manual_record,
//                              color: Colors.grey[300],
//                              size: 8.0,
//                            ),
//                            SizedBox(
//                              height: 5,
//                            ),
//                            Icon(
//                              Icons.fiber_manual_record,
//                              color: Colors.grey[300],
//                              size: 8.0,
//                            ),
//                            SizedBox(
//                              height: 5,
//                            ),
//                            Icon(
//                              Icons.fiber_manual_record,
//                              color: Colors.grey[300],
//                              size: 8.0,
//                            ),
//                          ],
//                        ),
//                        SizedBox(
//                          width: 10,
//                        ),
//
//
//
//
//
////                        Container(
////                          height: 80,
////                          width: MediaQuery.of(context).size.width / 1.4,
////                          child: ClipRRect(
////                            borderRadius: BorderRadius.only(
////                              topLeft: Radius.circular(30),
////                              topRight: Radius.circular(30),
////                              bottomRight: Radius.circular(30),
////                              bottomLeft: Radius.circular(30),
////                            ),
////                            child: Align(
////                              alignment: Alignment.bottomRight,
////                              heightFactor: 0.3,
////                              widthFactor: 2.5,
////                              child: GoogleMap(
////                                myLocationEnabled: false,
////                                compassEnabled: false,
////                                tiltGesturesEnabled: false,
////                                markers: _markers,
////                                mapType: MapType.normal,
////                                initialCameraPosition: initialLocation,
////                                onMapCreated: onMapCreated,
////                                onLongPress: (LatLng latLng) {
////                                  // creating a new MARKER
////
////                                  var markerIdVal = _markers.length + 1;
////                                  MarkerId markerId =
////                                      MarkerId(markerIdVal.toString());
////                                  final Marker marker = Marker(
////                                      markerId: markerId, position: latLng);
////
////                                  markers[markerId] = marker;
////                                },
////                              ),
////                            ),
////                          ),
////                        ),
//
//
//
//
//
//                      ],
//                    ),
//                    SizedBox(
//                      height: 2,
//                    ),
//                    Row(
//                      children: <Widget>[
//                        SizedBox(
//                          width: 20,
//                        ),
//                        Icon(
//                          Icons.fiber_manual_record,
//                          color: Colors.orangeAccent,
//                          size: 15.0,
//                        ),
//                        Text(
//                          '   ' +
//                          DateFormat.MMMMd().format(updatedate2) +
//                              ' ' +
//                              ', ' +
//                              updatedate2.hour.toString() +
//                              ':' +
//                              updatedate2.minute.toString(),
//                          style: TextStyle(
//                            fontSize: 14,
//                            color: Colors.grey[400],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//              ],
//            ),
//          );
//        });
//  }
//}
//
//
//
//
//class MyDialog extends StatefulWidget {
//
//  const MyDialog({
//    this.onValueChange,
//    this.initialValue,
//    this.slugg,
//    this.title,
//    this.ref,
//    this.category
//  });
//
//  final String initialValue;
//  final void Function(String) onValueChange;
//  final String slugg;
//  final String title;
//  final String ref;
//  final String category;
//
//  @override
//  State createState() => new MyDialogState();
//}
//
//
//
//class MyDialogState extends State<MyDialog> {
//  final AnimatedQRViewController controller = AnimatedQRViewController();
//  String _selectedId;
//  final _key= GlobalKey<FormState>();
//  Color myColor = Color(0xff00bfa5);
//
//   TextEditingController TitleController ;
//   TextEditingController CategoryController ;
//   TextEditingController RefController ;
//
//  @override
//  void initState() {
//    super.initState();
//    _selectedId = widget.initialValue;
//
//    TitleController = TextEditingController(text: widget.title);
//    print("TitleController");
//    print(TitleController);
//
//    RefController = TextEditingController(text: widget.ref);
//    CategoryController = TextEditingController(text: widget.category);
//
//  }
//
//
//  DatabaseHelper databaseHelper = new DatabaseHelper();
//
//  void _doSomething() async {
//    if (_key.currentState.validate()) {
//      databaseHelper.editDevice(
//          TitleController.text,
//          CategoryController.text,
//          RefController.text,
//          widget.slugg.trim(),
//      );
//    }
//  }
//
//  Widget build(BuildContext context) {
//    return AlertDialog(
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(32.0))
//        ),
//        contentPadding: EdgeInsets.only(top: 10.0),
//        content: SingleChildScrollView(
////        width: 300.0,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    "Edit device",
//                    style: TextStyle(fontSize: 24.0),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 5.0,
//              ),
//              Divider(
//                color: Colors.grey,
//                height: 4.0,
//              ),
//              Padding(
//                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
//                  child:Column(
//                    children: <Widget>[
//                      SizedBox(
//                        height: 10.0,
//                      ),
//                      Form(
//                        key: _key,
//                        child: Column(
//                            children: <Widget>[
//                              Container(
//                                height: MediaQuery.of(context).size.height / 3 ,
//                                width:MediaQuery.of(context).size.width - 20,
//                                child: AnimatedQRView(
//                                  squareColor: Colors.green.withOpacity(0.25),
//                                  animationDuration: const Duration(milliseconds: 600),
//                                  onScanBeforeAnimation: (String str) {
//                                    print('Callback at the beginning of animation: $str');
//                                  },
//                                  onScan: (str) async {
//                                    await showDialog(
//                                      context: context,
//                                      builder: (context) => AlertDialog(
//                                        title: Text('ID : $str'),
//                                        actions: [
//                                          FlatButton(
//                                            child: const Text('OK'),
//                                            onPressed: () {
//                                              RefController.text = str;
//                                              Navigator.of(context).pop();
//                                            },
//                                          ),
//                                          FlatButton(
//                                            child: const Text('Rescan'),
//                                            onPressed: () {
//                                              Navigator.of(context).pop();
//                                              controller.resume();
//                                            },
//                                          ),
//                                        ],
//                                      ),
//                                    );
//                                  },
//                                  controller: controller,
//                                ),
//                              ),
//                              TextFormField(
//                                validator: (value){
//                                  if (value.isEmpty){
//                                    return " Device name can not be empty";
//                                  }else
//                                    return null;
//                                },
//                                controller: TitleController,
//                                decoration: InputDecoration(
//                                    icon: Icon(Icons.devices, color: Colors.grey[400]),
//                                    border: InputBorder.none,
//                                    hintText: "Device Name",
//                                    hintStyle: TextStyle(color: Colors.grey[400])
//                                ),
//                              ),
//                              DropdownButton<String>(
//                                isExpanded: true,
//                                hint:  Text("Pick a category"),
//                                value: CategoryController.text,
//                                onChanged: (String value) {
//                                  setState(() {
//                                    CategoryController.text = value;
//                                  });
//                                  widget.onValueChange(value);
//                                },
//                                items: <String>['humains', 'animals', 'car', 'object'].map((String value) {
//                                  return  DropdownMenuItem<String>(
//                                    value: value,
//                                    child: Text(value),
//                                  );
//                                }).toList(),
//                              ),
//                              TextFormField(
//                                validator: (value){
//                                  if (value.isEmpty){
//                                    return " Device ID can not be empty";
//                                  }else
//                                    return null;
//                                },
//                                controller: RefController,
//                                decoration: InputDecoration(
//                                    icon: Icon(Icons.settings_overscan, color: Colors.grey[400]),
//                                    border: InputBorder.none,
//                                    hintText: "REF",
//                                    hintStyle: TextStyle(color: Colors.grey[400])),
//                              ),
//                            ]
//                        ),
//                      ),
//                    ],
//                  )
//              ),
//              InkWell(
//                splashColor: myColor,
//                child:
//                Container(
//                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                  decoration: BoxDecoration(
//                    color: myColor,
//                    borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(32.0),
//                        bottomRight: Radius.circular(32.0)),
//                  ),
//                  child: Text(
//                    "Confirm",
//                    style: TextStyle(color: Colors.white),
//                    textAlign: TextAlign.center,
//                  ),
//                ),
//                onTap: () {
//                  _doSomething();
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          ),
//        ));
//
//
//
//
//
//
//
//
//
////  Widget build(BuildContext context) {
////    return
////      SimpleDialog(
////        title: Text("New Device"),
////        children: <Widget>[
////          Form(
////            key: _key,
////            child: Column(
////            children: <Widget>[
////              Container(
////                height: MediaQuery.of(context).size.height / 3 ,
////                width:MediaQuery.of(context).size.width - 20,
////                child: AnimatedQRView(
////                  squareColor: Colors.green.withOpacity(0.25),
////                  animationDuration: const Duration(milliseconds: 600),
////                  onScanBeforeAnimation: (String str) {
////                    print('Callback at the beginning of animation: $str');
////                  },
////                  onScan: (str) async {
////                    await showDialog(
////                      context: context,
////                      builder: (context) => AlertDialog(
////                        title: Text('ID : $str'),
////                        actions: [
////                          FlatButton(
////                            child: const Text('OK'),
////                            onPressed: () {
////                              IDController.text = str;
////                              Navigator.of(context).pop();
////                            },
////                          ),
////                          FlatButton(
////                            child: const Text('Rescan'),
////                            onPressed: () {
////                              Navigator.of(context).pop();
////                              controller.resume();
////                            },
////                          ),
////                        ],
////                      ),
////                    );
////                  },
////                  controller: controller,
////                ),
////              ),
////
////              TextFormField(
////                validator: (value){
////                  if (value.isEmpty){
////                    return " Device name can not be empty";
////                  }else
////                    return null;
////                },
////                controller: emailController,
////                decoration: InputDecoration(
////                    icon: Icon(Icons.devices, color: Colors.grey[400]),
////                    border: InputBorder.none,
////                    hintText: "Device name",
////                    hintStyle: TextStyle(color: Colors.grey[400])),
////              ),
////              DropdownButton<String>(
////                hint:  Text("Pick a category"),
////                value: _selectedId,
////                onChanged: (String value) {
////                  setState(() {
////                    _selectedId = value;
////                  });
////                  widget.onValueChange(value);
////                },
////                items: <String>['humains', 'animals', 'car', 'object'].map((String value) {
////                  return  DropdownMenuItem<String>(
////                    value: value,
////                    child: Text(value),
////                  );
////                }).toList(),
////              ),
////              TextFormField(
////                validator: (value){
////                  if (value.isEmpty){
////                    return " Device ID can not be empty";
////                  }else
////                    return null;
////                },
////                controller: IDController,
//////                onChanged: (text) => {code},
////                decoration: InputDecoration(
////                    icon: Icon(Icons.devices, color: Colors.grey[400]),
////                    border: InputBorder.none,
////                    hintStyle: TextStyle(color: Colors.grey[400])),
////              ),
////              FlatButton(
////                color: Colors.blue,
////                textColor: Colors.white,
////                disabledColor: Colors.grey,
////                disabledTextColor: Colors.black,
////                padding: EdgeInsets.all(8.0),
////                splashColor: Colors.blueAccent,
////                onPressed: () {
////                  print("clicked");
////                  print(_selectedId);
////                  _doSomething();
////                },
////                child: Text(
////                  "Confirm",
////                  style: TextStyle(fontSize: 20.0),
////                ),
////              )
////            ]
////        ),
////      ),
////      ],
////    );
////  }
//
//
//
//
//
//
//
//
//
//
//
//
//  }
//
//}





/******************************************************************************************************************************/


import 'dart:async';
import 'dart:ui';

import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_v1/Pages/Dashboard/dashscreen.dart';
import 'package:front_v1/Pages/DevicePage/DeviceScreen.dart';
import 'package:front_v1/Pages/HomePage/app_home_screen.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:front_v1/src/locations.dart' as locations;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math' as math;
import 'package:geocoder/geocoder.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:vibrate/vibrate.dart';





class DeviceShowDetails extends StatefulWidget {
  List list;
  int index;
  String slugg;
  DeviceShowDetails({this.index, this.list, this.slugg});
  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<DeviceShowDetails>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Widget tabBody = Container(
    color: AppTheme.background,
  );

  DatabaseHelper2 databaseHelper = new DatabaseHelper2();
  get slugg => widget.slugg;
  String _selectedId;

  IconData iconchoice() {
    var grade = widget.list[widget.index]['category'];
    switch (grade) {
      case "human":
        {
          return Icons.person_outline;
        }
        break;
      case "animal":
        {
          return Icons.adb;
        }
        break;
      case "car":
        {
          return Icons.local_shipping;
        }
        break;
      case "object":
        {
          return Icons.child_friendly;
        }
        break;
    }
  }

  String imagechoice() {
    var grade = widget.list[widget.index]['category'];
    switch (grade) {
      case "human":
        {
          return 'assets/images/plant2.png';
        }
        break;
      case "animal":
        {
          return 'assets/images/plant0.png';
        }
        break;
      case "car":
        {
          return 'assets/images/plant2.png';
        }
        break;
      case "object":
        {
          return 'assets/images/plant1.png';
        }
        break;
    }

  }

//  ScrollController _controller;

  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor PIN;
  BitmapDescriptor pinLastLocationIcon;

  @override
  void initState() {
//    _controller = ScrollController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DashScreen(animationController: animationController);

    super.initState();
    setCustomMapPin();
    setCustomMapLastPin();
    isPressed = widget.list[widget.index]['favorit'];
    isTraking = widget.list[widget.index]['traking'];
  }

void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/location.png');
  }

void setCustomMapLastPin() async {
    pinLastLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/location-pin.png');
  }



  bool isTraking;
  _traking() {
    var newVal = true;
    if (isTraking) {
      databaseHelper.Updatetraking(
          slugg,
          false
      );
      newVal = false;
    } else {
      databaseHelper.Updatetraking(
          slugg,
          true
      );
      newVal = true;
    }
    setState(() {
      isTraking = newVal;
    });
  }



  bool isPressed;
  _pressed() {
    var newVal = true;
    if (isPressed) {
      databaseHelper.UpdateFavorit(
          slugg,
          false
      );
      newVal = false;
    } else {
      databaseHelper.UpdateFavorit(
          slugg,
          true
      );
      newVal = true;
    }
    setState(() {
      isPressed = newVal;
    });
  }

  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(32.1139182, 9.5956896);

  void confirm (){
    AlertDialog alertDialog =  AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: Colors.white,

      content:  Text(" You want to delete '${widget.list[widget.index]['title']}'"),
      actions: <Widget>[

        RaisedButton(
          child:  Text("CANCEL",style:  TextStyle(color: Colors.green)),
          color: Colors.white,
          onPressed: ()=> Navigator.pop(context),
        ),

        RaisedButton(
          child:  Text("OK DELETE!",style:  TextStyle(color: Colors.red)),
          color: Colors.white,
          onPressed: (){
            _delete();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppHomeScreen()));
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

String batterie ="";
  Future<void> _onMapCreated(GoogleMapController controller) async {
//    controller.setMapStyle(Utils.mapStyles);
    setState(() {
      _markers.clear();
      int i = widget.list[widget.index]["datas"].length-1;
      for (final Deviceslocation in widget.list[widget.index]["datas"]) {


   if (Deviceslocation["LAT"] != null && Deviceslocation["LNG"] != null){

        if (i == widget.list[widget.index]["datas"].length-1) {
          PIN = pinLastLocationIcon;
        } else {
          PIN = pinLocationIcon;
        }

        batterie = Deviceslocation["batterie"].toString() +'%';

        final marker = Marker(
            markerId: MarkerId(Deviceslocation["time"].toString()),
            position: LatLng(Deviceslocation["LAT"], Deviceslocation["LNG"]),
            infoWindow: InfoWindow(
              title: ("Your " + i.toString() + "th location* "),
//              snippet: ( Deviceslocation["LAT"].toString() +Deviceslocation["LNG"].toString() ) ,
              snippet: ( 'Your battery level :'+batterie) ,
            ),
            icon: PIN,
        );
        _markers[Deviceslocation["time"].toString()] = marker;

    }

        i--;
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: SafeArea(
                  child: Column(children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 35,
                      width: MediaQuery.of(context).size.width,
                      child:
                      Stack(children: <Widget>[
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          mapType: MapType.normal,
                          compassEnabled: true,
                          zoomGesturesEnabled: true,
                          myLocationEnabled: true,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          tiltGesturesEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 6.0,
                          ),
                          markers: _markers.values.toSet(),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.05,

//                      MediaQuery.of(context).size.height -
//                          MediaQuery.of(context).size.height + 30

                              right: 20,
                              left: 0),
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: const Radius.circular(30.0),
                                topRight: const Radius.circular(30.0),
                              ),
                              boxShadow: []),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppHomeScreen()));
//                      Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 40.0,
                                  color: AppTheme.nearlyDarkGeen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // CARD VIEW  *********************************************************




                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.61,
                              right: 0,
                              left: 0),
                          height: MediaQuery.of(context).size.width * 0.55 ,
                          width: MediaQuery.of(context).size.width / 1.4,






//                  margin: EdgeInsets.only(
//                      top: MediaQuery.of(context).size.height - 320,
//                      right: 0,
//                      left: 0),
//                  height: 230,
//                  width: MediaQuery.of(context).size.width / 1.4,






                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: const Radius.circular(30.0),
                                topRight: const Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(.1),
                                    blurRadius: 2,
                                    spreadRadius: 2),
                              ]),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${DateFormat("MMM dd, yyyy").format(DateTime.now())}',
                                style: TextStyle(
                                  color: AppTheme.nearlyDarkGeen,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '${widget.list[widget.index]['title'].toUpperCase()}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'NAME',
                                        style: TextStyle(
                                            color: Colors.grey[400], fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Container(
                                    height: 12,
                                    child: VerticalDivider(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[400],
                                      ),
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    child: Icon(iconchoice(),
                                        size: 35, color: AppTheme.nearlyDarkGeen),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '${widget.list[widget.index]['category'].toUpperCase()}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'CATEGORY',
                                        style: TextStyle(
                                            color: Colors.grey[400], fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 80,
                                        height: 35,
                                        child:

                                        IconButton(
                                          icon: Icon(isPressed
                                              ? Icons.favorite
                                              : Icons.favorite_border
                                          ),
                                          onPressed: () => _pressed(),
                                          iconSize: 40.0,
                                          color: Colors.pink,
                                        ),



                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height - 320,
                              right: 0,
                              left: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width / 4.8),
                          child: Column(
                            children: <Widget>[

                              Container(
                                height: MediaQuery.of(context).size.width / 6.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                      bottomLeft: const Radius.circular(20.0),
                                      topLeft: const Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12.withOpacity(.1),
                                          blurRadius: 2,
                                          spreadRadius: 2),
                                    ]),
                                child:


                            IconButton(
                                    icon: Icon(isTraking
                                        ? Icons.gps_fixed
                                        : Icons.gps_off
                                    ),
                                    onPressed: () => _traking(),
                                    iconSize: 40.0,
                                    color: Colors.blueAccent,
                                  ),


                              ),
                              SizedBox(
                                height: 10,
                              ),


                              Container(
                                height: MediaQuery.of(context).size.width / 6.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                      bottomLeft: const Radius.circular(20.0),
                                      topLeft: const Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12.withOpacity(.1),
                                          blurRadius: 2,
                                          spreadRadius: 2),
                                    ]),


                                child: GestureDetector(
                                  onTap: () {
                                    Vibrate.vibrate();
                                    print("onTap");
                                    Fluttertoast.showToast(
                                        msg: "  Make a long press  ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 20.0
                                    );
                                  },
                                  onLongPress: (){
                                    print("onLongPress");
                                    print(widget.list[widget.index]['ref'].toString());
//                                    confirm ();
                                    showDialog(
                                        context: context,
                                        child: MyDialog(
                                          onValueChange: _onValueChange,
                                          initialValue: _selectedId,
                                          slugg: slugg,
                                          title: widget.list[widget.index]['title'],
                                          ref: widget.list[widget.index]['ref'],
                                          category: widget.list[widget.index]['category'],
                                        ));

                                  },
                                  child:Icon(Icons.settings, size: 34 ,color: Colors.white),
                                ),




                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Container(
                                height: MediaQuery.of(context).size.width / 6.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                      bottomLeft: const Radius.circular(20.0),
                                      topLeft: const Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12.withOpacity(.1),
                                          blurRadius: 2,
                                          spreadRadius: 2),
                                    ]),

                                child: GestureDetector(
                                  onTap: () {

                                    print("onTap");
                                    Vibrate.vibrate();

                                    Fluttertoast.showToast(
                                        msg: "  Make a long press  ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 20.0
                                    );
                                  },
                                  onLongPress: (){
                                    print("onLongPress");
                                    confirm ();
                                  },
                                  child:Icon(Icons.delete, size: 34 ,color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        ),


                        SlidingUpPanel(
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                          minHeight: MediaQuery.of(context).size.width * 0.13,
//                          minHeight: 50,
                          panel: Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.nearlyDarkGeen,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  height: 5,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Divider(
                                      color: AppTheme.nearlyDarkGeen, thickness: 3),
                                ),
                                SizedBox(
                                  height: 15,
                                ),



                                Container(
                                  height: MediaQuery.of(context).size.height / 1.45,
                                  child:

                                  FutureBuilder(
                                    future: databaseHelper2.getDataOfDeviceByID(slugg),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) print(snapshot.error);
                                      return snapshot.hasData
                                          ? ItemList(list: snapshot.data)
                                          : Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              AppTheme.nearlyDarkGeen),
                                        ),
                                      );
                                    },
                                  ),

                                ),



                              ],
                            ),
                          ),
                          collapsed: Container(
                            decoration: BoxDecoration(
                                color: Colors.white, borderRadius: radius),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.nearlyDarkGeen,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  height: 5,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Divider(
                                      color: AppTheme.nearlyDarkGeen, thickness: 3),
                                ),
                              ],
                            ),
                          ),
                          borderRadius: radius,
                        ),
                      ]),
                    ),
                  ]))),
        ));
  }

    void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  void _delete() async {
    databaseHelper.RemoveDevice(slugg);
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return ListView.builder(
          itemCount: list == null ? 0 : list.length ,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, i) {

            var t ;
            var t2 ;

            var _address1;
            var _address2 ;

            Duration diffDt;

            _address1 = list[i]['adress_device'].toString();
            _address2 = list[i]['adress_device'].toString();

            t = list[i]['time'].toString();
            t2 = list[i]['time'].toString();







//            if (i==0)
//              {
//                _address2 = " your start from here .. ";
//                t2 = list[0]['time'].toString();
//
//              }else if (i+1 > 0 && i+1 < list.length )
//              {
//              _address2 = list[i+1]['adress_device'].toString();
//              t2 = list[i+1]['time'].toString();
//              }

            if (i == list.length-1)
            {
              _address2 = " your start from here .. ";
              t2 = list[list.length-1]['time'].toString();

            }else if (i+1 > 0 && i+1 < list.length){
              _address2 = list[i+1]['adress_device'].toString();
              t2 = list[i+1]['time'].toString();
            }


            var int1 = int.tryParse(t);
            var int2 = int.tryParse(t2);
            var updatedate = DateTime.fromMillisecondsSinceEpoch(int1);
            var updatedate2 = DateTime.fromMillisecondsSinceEpoch(int2);




            var sss = DateTime.now().difference(
                DateTime.fromMillisecondsSinceEpoch(
                    int.tryParse(list[0]['time'].toString())));




            if (i == 0) {
              diffDt = sss;
            } else if (i > 0 && i < list.length - 1) {
              diffDt = updatedate
                  .difference(
                  updatedate2);
            } else {
              diffDt = updatedate2
                  .difference(updatedate);
            };




            Icon iconchoic() {
              if (list[i]['batterie'] >= 0 && list[i]['batterie'] < 30) {
                return Icon(
                  Icons.battery_alert,
//                    size: 200,
                  color: Colors.red,
                );
                ;
              } else
              if (list[i]['batterie'] >= 30 && list[i]['batterie'] < 60) {
                return Icon(
                  Icons.battery_full,
//                    size: 200,
                  color: Colors.yellow,
                );
                ;
              } else {
                return Icon(
                  Icons.battery_charging_full,
//                    size: 200,
                  color: Colors.green,
                );
              }
            };






            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Stay here :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          )),
                      Row(children: <Widget>[
                        Text(
                          'Travel time : ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),

                        Text(
                          updatedate.hour.toString() +
                              ':' +
                              updatedate.minute.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.nearlyDarkGeen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
//                      Text(
//                        updatedate.hour.toString() +
//                            ':' +
//                            updatedate.minute.toString(),
//                        style: TextStyle(
//                          fontSize: 15,
//                          color: AppTheme.nearlyDarkGeen,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                          diffDt.inMinutes.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('min'),
                      ]),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Transform.rotate(
                            angle: 90 * math.pi / 180,
                            child: iconchoic(),
                          ),
                          Text(
                            list[i]['batterie'].toString()+' %',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: Colors.greenAccent,
                            size: 15.0,
                          ),
                          Text(
                            _address1 + '\n' +
                                DateFormat.MMMMd().format(updatedate) +
                                ' ' +
                                ', ' +
                                updatedate.hour.toString() +
                                ':' +
                                updatedate.minute.toString(),


//                            '   ' +
//                              DateFormat.MMMMd().format(updatedate) +
//                              ' ' +
//                              ', ' +
//                              updatedate.hour.toString() +
//                              ':' +
//                              updatedate.minute.toString(),


                            style: TextStyle(
                              fontSize: 12,
//                            color: Colors.grey[400],
                              color: Colors.black,
                            ),
                          ),


                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.fiber_manual_record,
                                color: Colors.grey[300],
                                size: 8.0,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.fiber_manual_record,
                                color: Colors.grey[300],
                                size: 8.0,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.fiber_manual_record,
                                color: Colors.grey[300],
                                size: 8.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),


//                        Container(
//                          height: 80,
//                          width: MediaQuery.of(context).size.width / 1.4,
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(30),
//                              topRight: Radius.circular(30),
//                              bottomRight: Radius.circular(30),
//                              bottomLeft: Radius.circular(30),
//                            ),
//                            child: Align(
//                              alignment: Alignment.bottomRight,
//                              heightFactor: 0.3,
//                              widthFactor: 2.5,
//                              child: GoogleMap(
//                                myLocationEnabled: false,
//                                compassEnabled: false,
//                                tiltGesturesEnabled: false,
//                                markers: _markers,
//                                mapType: MapType.normal,
//                                initialCameraPosition: initialLocation,
//                                onMapCreated: onMapCreated,
//                                onLongPress: (LatLng latLng) {
//                                  // creating a new MARKER
//
//                                  var markerIdVal = _markers.length + 1;
//                                  MarkerId markerId =
//                                      MarkerId(markerIdVal.toString());
//                                  final Marker marker = Marker(
//                                      markerId: markerId, position: latLng);
//
//                                  markers[markerId] = marker;
//                                },
//                              ),
//                            ),
//                          ),
//                        ),


                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.fiber_manual_record,
                            color: Colors.orangeAccent,
                            size: 15.0,
                          ),
                          Text(


                            _address2 + '\n' +
                                DateFormat.MMMMd().format(updatedate2) +
                                ' ' +
                                ', ' +
                                updatedate2.hour.toString() +
                                ':' +
                                updatedate2.minute.toString(),


//                          '   ' +
//                              DateFormat.MMMMd().format(updatedate2) +
//                              ' ' +
//                              ', ' +
//                              updatedate2.hour.toString() +
//                              ':' +
//                              updatedate2.minute.toString(),


                            style: TextStyle(
                              fontSize: 12,
//                            color: Colors.grey[400],
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),


/*

                  Container(
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child:
                    Row(
                        children: <Widget>[
//                              SizedBox(
//                                width: 25,
//                              ),
                          Text('Arrivé'),
                          Text('Arrivé'),
                          Text('Arrivé'),
                          Text('Arrivé'),
                        ]
                    ),
//                      Center(
//                        child:
//                        Column(
//                          children: <Widget>[
//
//                            Row(
//                                children: <Widget>[
////                              SizedBox(
////                                width: 25,
////                              ),
//                                  Text('Arrivé'),
//                                  Text('Arrivé'),
//                                  Text('Arrivé'),
//                                  Text('Arrivé'),
//                                ]
//                            ),
//
//                            Row(
//                              children: <Widget>[
////                            SizedBox(
////                              width: 25,
////                            ),
//                                Row(
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.play_circle_outline ,
//                                      color: AppTheme.nearlyDarkGeen,
//                                      size: 30.0,
//                                    ),
//                                    SizedBox(
//                                      width: 5,
//                                    ),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                          border: Border.all(
//                                            color: AppTheme.nearlyDarkGeen,
//                                          ),
//                                          borderRadius:
//                                          BorderRadius.all(Radius.circular(50))),
//                                      height: 3,
//                                      width: MediaQuery.of(context).size.width / 8,
//                                      child: Divider(
//                                          color: AppTheme.nearlyDarkGeen, thickness: 1),
//                                    ),
//                                  ],
//                                ),
//
//                                Row(
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.check_circle_outline,
//                                      color: AppTheme.nearlyDarkGeen,
//                                      size: 30.0,
//                                    ),
//                                    SizedBox(
//                                      width: 5,
//                                    ),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                          border: Border.all(
//                                            color: AppTheme.nearlyDarkGeen,
//                                          ),
//                                          borderRadius:
//                                          BorderRadius.all(Radius.circular(50))),
//                                      height: 3,
//                                      width: MediaQuery.of(context).size.width / 8,
//                                      child: Divider(
//                                          color: AppTheme.nearlyDarkGeen, thickness: 1),
//                                    ),
//                                  ],
//                                ),
//
//                                Row(
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.check_circle_outline,
//                                      color: AppTheme.nearlyDarkGeen,
//                                      size: 30.0,
//                                    ),
//                                    SizedBox(
//                                      width: 5,
//                                    ),
//                                    Container(
//                                      decoration: BoxDecoration(
//                                          border: Border.all(
//                                            color: AppTheme.nearlyDarkGeen,
//                                          ),
//                                          borderRadius:
//                                          BorderRadius.all(Radius.circular(50))),
//                                      height: 3,
//                                      width: MediaQuery.of(context).size.width / 8,
//                                      child: Divider(
//                                          color: AppTheme.nearlyDarkGeen, thickness: 1),
//                                    ),
//                                  ],
//                                ),
//
//                                Row(
//                                  children: <Widget>[
//                                    Icon(
//                                      Icons.check_circle,
//                                      color: AppTheme.nearlyDarkGeen,
//                                      size: 30.0,
//                                    ),
//                                  ],
//                                ),
//
//                              ],
//                            ),
//
//
//                          ],
//                        ),
//
//                      )

                  ),



                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[

//                          Text('Arrivé'),
                          Row(
                              children: <Widget>[
                                Text('Arrivé'),
                                Text('Arrivé'),
                                Text('Arrivé'),
                                Text('Arrivé'),
                              ]),

                          Row(
                            children: <Widget>[



                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.play_circle_outline ,
                                    color: AppTheme.nearlyDarkGeen,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.nearlyDarkGeen,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                    height: 3,
                                    width: MediaQuery.of(context).size.width / 8,
                                    child: Divider(
                                        color: AppTheme.nearlyDarkGeen, thickness: 1),
                                  ),
                                ],
                              ),


                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppTheme.nearlyDarkGeen,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.nearlyDarkGeen,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                    height: 3,
                                    width: MediaQuery.of(context).size.width / 8,
                                    child: Divider(
                                        color: AppTheme.nearlyDarkGeen, thickness: 1),
                                  ),
                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppTheme.nearlyDarkGeen,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.nearlyDarkGeen,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                    height: 3,
                                    width: MediaQuery.of(context).size.width / 8,
                                    child: Divider(
                                        color: AppTheme.nearlyDarkGeen, thickness: 1),
                                  ),
                                ],
                              ),



                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    color: AppTheme.nearlyDarkGeen,
                                    size: 30.0,
                                  ),
                                ],
                              ),







                            ],
                          ),
                        ],
                      )
                    ],
                  ),

      */


                ],
              ),
            );






          });
  }



}






class MyDialog extends StatefulWidget {

  const MyDialog({
    this.onValueChange,
    this.initialValue,
    this.slugg,
    this.title,
    this.ref,
    this.category
  });

  final String initialValue;
  final void Function(String) onValueChange;
  final String slugg;
  final String title;
  final String ref;
  final String category;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  final AnimatedQRViewController controller = AnimatedQRViewController();
  String _selectedId;
  final _key= GlobalKey<FormState>();
  Color myColor = Color(0xff00bfa5);

   TextEditingController TitleController ;
   TextEditingController CategoryController ;
   TextEditingController RefController ;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;

    TitleController = TextEditingController(text: widget.title);
    RefController = TextEditingController(text: widget.ref);
    CategoryController = TextEditingController(text: widget.category);


  }


  DatabaseHelper2 databaseHelper = new DatabaseHelper2();

  void _doSomething() async {
    if (_key.currentState.validate()) {
      databaseHelper.UpdateDevice(
        TitleController.text,
        RefController.text,
        CategoryController.text,
        widget.slugg.trim(),
      );
    }
  }

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
                    "Edit device",
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
                        key: _key,
                        child: Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 3 ,
                                width:MediaQuery.of(context).size.width - 20,
                                child: AnimatedQRView(
                                  squareColor: Colors.green.withOpacity(0.25),
                                  animationDuration: const Duration(milliseconds: 600),
                                  onScanBeforeAnimation: (String str) {
                                    print('Callback at the beginning of animation: $str');
                                  },
                                  onScan: (str) async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('ID : $str'),
                                        actions: [
                                          FlatButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              RefController.text = str;
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: const Text('Rescan'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              controller.resume();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  controller: controller,
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Device name can not be empty";
                                  }else
                                    return null;
                                },
                                controller: TitleController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.devices, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "Device Name",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint:  Text("Pick a category"),
                                value: CategoryController.text,
                                onChanged: (String value) {
                                  setState(() {
                                    CategoryController.text = value;
                                  });
                                  widget.onValueChange(value);
                                },
                                items: <String>['human', 'animal', 'car', 'object'].map((String value) {
                                  return  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              TextFormField(
                                validator: (value){
                                  if (value.isEmpty){
                                    return " Device ID can not be empty";
                                  }else
                                    return null;
                                },
                                controller: RefController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.settings_overscan, color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    hintText: "REF",
                                    hintStyle: TextStyle(color: Colors.grey[400])),
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }

}




class CrazySwitch extends StatefulWidget {
  @override
  _CrazySwitchState createState() => _CrazySwitchState();
}

class _CrazySwitchState extends State<CrazySwitch> with SingleTickerProviderStateMixin{

  bool isChecked = false;
  Duration _duration = Duration(milliseconds: 370);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: _duration
    );

    _animation = AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight
    ).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child){
        return Container(
          width: 80,
          height: 35,
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
          decoration: BoxDecoration(
              color: isChecked ? Colors.green : Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: isChecked ? Colors.green : Colors.red,
                    blurRadius: 12,
                    offset: Offset(0, 8)
                )
              ]
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _animation.value,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(_animationController.isCompleted){
                        _animationController.reverse();
                      }else{
                        _animationController.forward();
                      }

                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
