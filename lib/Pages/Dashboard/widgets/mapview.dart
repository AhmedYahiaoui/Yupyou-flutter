import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'dart:async';

class MapView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final double radiusTopRight;
  final double radiusBottomRight;

  Completer<GoogleMapController> _controller = Completer();

  MapView(
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
                height: 500.0,
                color: Colors.transparent,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(68),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 5.3,
                      widthFactor: 2.5,
                      child: MyMap(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  DatabaseHelper2 databaseHelper2 = new DatabaseHelper2();

  Completer<GoogleMapController> _controller = Completer();


//  destination_map_marker.png
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor dogLocationIcon;
  BitmapDescriptor persoLocationIcon;
  BitmapDescriptor carLocationIcon;
  BitmapDescriptor objLocationIcon;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

//  void setCustomMapPin() async {
//    dogLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/dog.png');
//
//    persoLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/group.png');
//
//    carLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/transport.png');
//
//    objLocationIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5),
//        'assets/images/map/boat.png');
//  }

  void setCustomMapPin() async {
    dogLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/adog.png');

    persoLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/baby.png');

    carLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/car.png');

    objLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map/obj.png');
  }


  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(34.322103, 9.7727366);


//  Future loaddata() async {
//    print("Loading Devices ..");




//    Future<void> _onMapCreated2(GoogleMapController controller) async {
//      await controller.setMapStyle(Utils.mapStyles);
//      await databaseHelper.getAllData2().then((devices) {
//        setState(() {
//        _markers.clear();
//        for (int i = 0; i < devices.length; i++) {
////          if (devices[i]["device_data"][0]['id'].toString()!= null){
//            //BitmapDescriptor
//          BitmapDescriptor iconchoice() {
//            var grade = devices[i]['category'];
//            switch (grade) {
//              case "human":
//                {
//                  return persoLocationIcon;
//                }
//                break;
//              case "animal":
//                {
//                  return dogLocationIcon;
//                }
//                break;
//              case "car":
//                {
//                  return carLocationIcon;
//                }
//                break;
//              case "object":
//                {
//                  return objLocationIcon;
//                }
//                break;
//            }
//          }
//            final marker = Marker(
//                markerId: MarkerId(devices[i]["id"].toString()),
//                position: LatLng(devices[i]["device_data"][0]['lat'],devices[i]["device_data"][0]['lng']),
//                infoWindow: InfoWindow(
//                  title: devices[i]["title"],
////            snippet: Deviceslocation.datas[0]?.lat.toString() +
////                " | " +
////                Deviceslocation.datas[0]?.lng.toString(),
//                ),
//                icon: iconchoice()
//            );
//
//            _markers[devices[i]["id"].toString()] = marker;
//          }
////       }
//      });
//    });
//  }


    Future<void> _onMapCreated2(GoogleMapController controller) async {
      await controller.setMapStyle(Utils.mapStyles);
      await databaseHelper2.AllDeviceByUser().then((devices) {
        setState(() {
        _markers.clear();
        for (int i = 0; i < devices.length; i++) {


          BitmapDescriptor iconchoice() {
            var grade = devices[i]['category'];

            switch (grade) {
              case "human":
                {
                  return persoLocationIcon;
                }
                break;
              case "animal":
                {
                  return dogLocationIcon;
                }
                break;
              case "car":
                {
                  return carLocationIcon;
                }
                break;
              case "object":
                {
                  return objLocationIcon;
                }
                break;
            }
          }

          if(devices[i]["datas"].length >0 ){
            print("device " + devices[i]["title"] + " m3abii y chabeb ****** :D ");
//            print(devices[i]["datas"].toString());

             final marker = Marker(
                markerId: MarkerId(devices[i]["datas"][0]['time'].toString()+devices[i]["date_published"].toString()),
                position: LatLng(
                    devices[i]["datas"][0]['LAT'],
                    devices[i]["datas"][0]['LNG']
                ),
                infoWindow: InfoWindow(
                  title: devices[i]["title"],
                ),
                icon: iconchoice()
            );

            _markers[devices[i]["datas"][0]['time'].toString()+devices[i]["date_published"].toString()] = marker;

          };

//            final marker = Marker(
//                markerId: MarkerId(devices[i]["datas"][0]['time'].toString()+devices[i]["date_published"].toString()),
//                position: LatLng(
//                    devices[i]["datas"][0]['LAT'],
//                    devices[i]["datas"][0]['LNG']
//                ),
//                infoWindow: InfoWindow(
//                  title: devices[i]["title"],
//                ),
//                icon: iconchoice()
//            );
//
//

//            _markers[devices[i]["datas"][0]['time'].toString()+devices[i]["date_published"].toString()] = marker;


          }
      });
    });
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
          child: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
            onMapCreated: _onMapCreated2,
            markers: _markers.values.toSet(),
          )),
    );
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
