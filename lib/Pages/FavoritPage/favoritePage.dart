import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_v1/Pages/Dashboard/widgets/LastDeviceAdded.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math' as math;

class FavoritDetails extends StatefulWidget {
  List list;
  int index;
  String slugg;
  FavoritDetails({this.index, this.list, this.slugg});
  @override
  _FavoritScreenState createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritDetails>
    with TickerProviderStateMixin {
  DatabaseHelper2 databaseHelper = new DatabaseHelper2();

  get slugg => widget.slugg;
  get index => widget.index;
  get list => widget.list;




  bool viewVisible = true ;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }
  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }



  @override
  void initState() {
    super.initState();
    isPressed = widget.list[widget.index]['favorit'];
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



  String imagechoice() {
    var grade = widget.list[widget.index]['category'];
    switch (grade) {
      case "human":
        {
          return 'assets/images/onedevice/plant1.png';
        }
        break;
      case "animal":
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
  DateTime time_date_published() {
    String grade = widget.list[widget.index]['date_published'];
    var long2 = int.tryParse(grade);
    var date = DateTime.fromMillisecondsSinceEpoch(long2);
    return date;
  }
  IconData iconFavorit() {
    if (widget.list[widget.index]['favorit'] == true) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
    ;
  }


  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[

                Container(
                  alignment: AlignmentDirectional(-0.93, -1.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                          icon: Icon(Icons.arrow_back , color: Colors.black),
                          iconSize: 34,
                          onPressed: ()=> Navigator.of(context).pop()),
                    ),
                  ),
                ),



                Container(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        heightFactor: 0.9,
                        widthFactor: 0.9,
                        child: MyMap(
                            slugg :slugg,
                            index:index,
                            list:list),
                      ),
                    ),
                  ),
                ),




                Container(
                  alignment: AlignmentDirectional(-0.56, -0.85),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          bottomRight: const Radius.circular(18.0),
                          topRight: const Radius.circular(18.0),
                          bottomLeft: const Radius.circular(18.0),
                          topLeft: const Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(.1),
                              blurRadius: 2,
                              spreadRadius: 2),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.list[widget.index]['title'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.exo2(
                                    color: Colors.black,
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    DateFormat.jm()
                                            .format(time_date_published())
                                            .toString() +
                                        '',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    DateFormat.yMMMMEEEEd()
                                        .format(time_date_published())
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.exo2(
                                        color: Color(0xFF8F8F8F),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(isPressed
                                    ? Icons.favorite
                                    : Icons.favorite_border
                                ),
                                onPressed: () => _pressed(),
                                iconSize: 30.0,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                Container(
                  alignment: AlignmentDirectional(1.2, 0.9),
                  child:Hero(
                    tag: widget.list[widget.index]['_id'].toString(),
                    child:Image.asset(
                      imagechoice(),
                      width: MediaQuery.of(context).size.width * .60,
                    ),
                    transitionOnUserGestures: true,
                  ),
                ),


                SlidingUpPanel(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.11,
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
                          width: MediaQuery.of(context).size.width / 8.5,
                          child: Divider(
                              color: AppTheme.nearlyDarkGeen, thickness: 3),
                        ),
                      ],
                    ),
                  ),
                  borderRadius: radius,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}



class MyMap extends StatefulWidget {
  List list;
  int index;
  String slugg;

//  MyMap(this.slugg);
//  MyMap(slugg,index,list );

  MyMap({this.index, this.list, this.slugg});

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor PIN;
  BitmapDescriptor pinLastLocationIcon;
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    setCustomMapPin();
    setCustomMapLastPin();
    super.initState();
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

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
      print("clickeeeeeeeeeeeeeed");
    });
  }


  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(33.9638852, 9.7465617);
  String batterie ="";






  Future<void> _onMapCreated(GoogleMapController controller) async {
//    controller.setMapStyle(Utils.mapStyles);
    setState(() {
      _markers.clear();
      int i = widget.list[widget.index]["datas"].length-1;
      for (final Deviceslocation in widget.list[widget.index]["datas"]) {

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
            snippet: ( 'Your battery level :'+batterie) ,
          ),
          icon: PIN,
        );

        _markers[Deviceslocation["time"].toString()] = marker;
        i--;
      }
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: Icon(
        icon,
        size: 30.0,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          )),
          child:
          Stack(
            children: <Widget>[
              GoogleMap(
                mapType: _currentMapType,
                zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
            onMapCreated: _onMapCreated,
            markers: _markers.values.toSet(),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
          ),

              Container(
                alignment: AlignmentDirectional(0.86, -0.85),
                child: Container(
                  height: MediaQuery.of(context).size.width / 5.1,
                  width: MediaQuery.of(context).size.width / 6.7,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(18.0),
                        topRight: const Radius.circular(18.0),
                        bottomLeft: const Radius.circular(18.0),
                        topLeft: const Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12.withOpacity(.1),
                            blurRadius: 2,
                            spreadRadius: 2),
                      ]),
//                  child: Icon(Icons.wb_sunny, size: 40, color: Colors.yellow),
                  child: button(_onMapTypeButtonPressed,Icons.map),

                ),
              ),

            ]
          ),
      ),
    );
  }
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


          print('Le i = : --------------------------------------> > > > > '+i.toString());


//          if (i == 0)
//          {
//            _address2 = " your start from here .. ";
//            t2 = list[0]['time'].toString();
//
//          }else if (i+1 > 0 && i+1 < list.length){
//            _address2 = list[i+1]['adress_device'].toString();
//            t2 = list[i+1]['time'].toString();
//          }




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
                    Text('Stay here',
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
                  height: 5,
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


