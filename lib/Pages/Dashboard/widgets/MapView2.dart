import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'dart:async';


class MapView2 extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final double radiusTopRight;
  final double radiusBottomRight;

  Completer<GoogleMapController> _controller = Completer();

  MapView2(
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
                      child: MyHomePage(),
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


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  DatabaseHelper databaseHelper = new DatabaseHelper();

//  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _controller;

  final Map<String, Marker> _markers = {};
  final LatLng _center = const LatLng(32.1139182, 9.5956896);



  Future<void> _onMapCreated2(GoogleMapController controller) async {
    await databaseHelper.getAllData2().then((devices) {
      setState(() {
        _markers.clear();
        for (int i = 0; i < devices.length; i++) {
          String title = devices[i]["title"];
          print("****************     title ****************");
          print(title);

          print("****************     devices[i][device_data][devices.length-1]  ****************");
          print(devices[i]["device_data"][0]['lat']);
          final marker = Marker(
            markerId: MarkerId(devices[i]["id"].toString()),
            position: LatLng(devices[i]["device_data"][0]['lat'],devices[i]["device_data"][0]['lng']),
            infoWindow: InfoWindow(
              title: devices[i]["title"],
            ),
          );
          _markers[devices[i]["id"].toString()] = marker;
        }
      });
    });
  }




//  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


//    coffeeShops.forEach((element) {
//
//
//      allMarkers.add(Marker(
//          markerId: MarkerId(element.shopName),
//          draggable: false,
//          infoWindow:
//          InfoWindow(title: element.shopName, snippet: element.address),
//          position: element.locationCoords));
//
//
//    });
//

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          coffeeShops[index].thumbNail),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coffeeShops[index].shopName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coffeeShops[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    coffeeShops[index].description,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(32.1139182, 9.5956896), zoom: 2.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
//                markers: _markers.values.toSet(),
//                onMapCreated: _onMapCreated,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: coffeeShops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}


class Coffee {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Coffee(
      {this.shopName,
        this.address,
        this.description,
        this.thumbNail,
        this.locationCoords});
}

final List<Coffee> coffeeShops = [
  Coffee(
      shopName: 'Stumptown Coffee Roasters',
      address: '18 W 29th St',
      description:
      'Coffee bar chain offering house-roasted direct-trade coffee, along with brewing gear & whole beans',
      locationCoords: LatLng(40.745803, -73.988213),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
  ),
  Coffee(
      shopName: 'Andrews Coffee Shop',
      address: '463 7th Ave',
      description:
      'All-day American comfort eats in a basic diner-style setting',
      locationCoords: LatLng(40.751908, -73.989804),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOfv3DSTkjsgvwCsUe_flDr4DBXneEVR1hWQCvR=w90-h90-n-k-no'
  ),
  Coffee(
      shopName: 'Third Rail Coffee',
      address: '240 Sullivan St',
      description:
      'Small spot draws serious caffeine lovers with wide selection of brews & baked goods.',
      locationCoords: LatLng(40.730148, -73.999639),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipPGoxAP7eK6C44vSIx4SdhXdp78qiZz2qKp8-o1=w90-h90-n-k-no'
  ),
  Coffee(
      shopName: 'Hi-Collar',
      address: '214 E 10th St',
      description:
      'Snazzy, compact Japanese cafe showcasing high-end coffee & sandwiches, plus sake & beer at night.',
      locationCoords: LatLng(40.729515, -73.985927),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNhygtMc1wNzN4n6txZLzIhgJ-QZ044R4axyFZX=w90-h90-n-k-no'
  ),
  Coffee(
      shopName: 'Everyman Espresso',
      address: '301 W Broadway',
      description:
      'Compact coffee & espresso bar turning out drinks made from direct-trade beans in a low-key setting.',
      locationCoords: LatLng(40.721622, -74.004308),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOMNvnrTlesBJwUcVVFBqVF-KnMVlJMi7_uU6lZ=w90-h90-n-k-no'
  )
];
