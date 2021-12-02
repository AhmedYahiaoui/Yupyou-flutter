import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_v1/Pages/DevicePage/widgets/Detail_view.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceDetails extends StatefulWidget {
  List list;
  int index;
  String slugg;

  DeviceDetails({this.index, this.list, this.slugg});

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<DeviceDetails> {


  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;


  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }




  List data;
  List userData;

  get slug => widget.slugg;

  DatabaseHelper databaseHelper = new DatabaseHelper();
  get slugg => widget.slugg;

  String imagechoice() {
    var grade = widget.list[widget.index]['category'];
    switch (grade) {
      case "humains":
        {
          return 'assets/images/plant2.png';
        }
        break;
      case "animals":
        {
          return 'assets/images/plant0.png';
        }
        break;
      case "cars":
        {
          return 'assets/images/plant2.png';
        }
        break;
      case "objects":
        {
          return 'assets/images/plant1.png';
        }
        break;
    }
    print("slugg");
    print(slugg);

    print("slug");
    print(slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 60.0,
                    ),
                    height: 620.0,
                    color:AppTheme.nearlyDarkGeen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.favorite,
                              size: 30.0,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          widget.list[widget.index]['category'].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.list[widget.index]['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          'FROM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.list[widget.index]['date_published'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          'SIZE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.list[widget.index]['username'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        RawMaterialButton(
                          padding: EdgeInsets.all(20.0),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.black,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () => print('Add to cart'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 30.0,
                    child: Hero(
                      tag: widget.list[widget.index]['title'],
                      child: Image(
                        height: 280.0,
                        width: 280.0,
                        image: AssetImage(imagechoice()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 450.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'All to know...',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            slug,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 8.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          GestureDetector(
                            child:

                            new FutureBuilder(
                              future: databaseHelper.getDataByDevice(slugg),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) print(snapshot.error);
                                return snapshot.hasData
                                    ? new ItemList(list: snapshot.data)
                                    : new Center(
                                        child: new CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  AppTheme.nearlyDarkGeen),
                                        ),
                                      );
                              },
                            ),


                          ),
                          Text(ItemList().toString()),


                          Container(
                            height: 280.0,
                            width: 400.0,
                            color: AppTheme.nearlyDarkGeen,
                            child: GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _center,
                                  zoom: 10.0,
                                ),
                                mapType: _currentMapType,
                                markers: _markers,
                                onCameraMove: _onCameraMove,
                              ),

                          ),





                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String listLast;



class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;


  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {




          return new Container(
            padding: const EdgeInsets.all(1.0),
            child: new GestureDetector(
              child: Stack(children: <Widget>[
                Row(children: <Widget>[
                  new Flexible(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

//
//
//                          Text(list[i]['lat'].toString(),
//                          style: TextStyle(
//                            color: Colors.grey[600],
//                            fontSize: 8.0,
//                            fontWeight: FontWeight.normal,
//                          )
//                          ),
//
//                          Text(list[i]['lng'].toString(),
//                              style: TextStyle(
//                                color: Colors.grey[600],
//                                fontSize: 8.0,
//                                fontWeight: FontWeight.normal,
//                              )
//                          ),
//                          SizedBox(height: 5.0),


                          Container(
                            height: 280.0,
                            width: 400.0,
                            color: AppTheme.nearlyDarkGeen,
//                            child: GoogleMap(
//                                onMapCreated: _onMapCreated,
//                                initialCameraPosition: CameraPosition(
//                                  target: _center,
//                                  zoom: 10.0,
//                                ),
//                                mapType: _currentMapType,
//                                markers: _markers,
//                                onCameraMove: _onCameraMove,
//                              ),

//                            child: PageView.builder(
//                              controller: _pageController,
//                              onPageChanged: (int index) {
//                                setState(() {
//                                  _selectedPage = index;
//                                });
//                              },
//                              itemCount: 1,
//                              itemBuilder: (BuildContext context, int index) {
//                                return _plantSelector();
//                              },
//                            ),
                          ),




//                          GoogleMap(
//                            onMapCreated: _onMapCreated,
//                            initialCameraPosition: CameraPosition(
//                              target: _center,
//                              zoom: 11.0,
//                            ),
//                            mapType: _currentMapType,
//                            markers: _markers,
//                            onCameraMove: _onCameraMove,
//                          ),




                    ],
                  )),
                ]),
              ]),
            ),
          );


        });
  }

}
