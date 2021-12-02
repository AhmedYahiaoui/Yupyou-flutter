//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:front_v1/src/locations.dart' as locations;
//import 'package:front_v1/src/locations.dart';
//
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//import 'package:flutter/services.dart';
//import 'package:front_v1/Service/DatabaseHelper.dart';
//import 'package:front_v1/Theme/app_theme.dart';
//import 'package:intl/intl.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//import 'package:http/http.dart' as http;
//
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  String slugg = "ahmed-device-4";
//  DatabaseHelper databaseHelper = new DatabaseHelper();
//
//  final Map<String, Marker> _markers = {};
//  Future<void> _onMapCreated(GoogleMapController controller) async {
//    final googleOffices = await locations.getYourDevices();
//    setState(() {
//      _markers.clear();
//      for (final Deviceslocation in googleOffices.Deviceslocations) {
//        print("La " + Deviceslocation.id.toString() + "éme Place  * ");
//
//        final marker = Marker(
//          markerId: MarkerId(Deviceslocation.id.toString()),
//          position: LatLng(Deviceslocation.lat, Deviceslocation.lng),
//          infoWindow: InfoWindow(
//            title: "La " + Deviceslocation.id.toString() + "éme Place  * ",
//            snippet: Deviceslocation.lat.toString() +
//                " | " +
//                Deviceslocation.lng.toString(),
//          ),
//        );
//
//        _markers[Deviceslocation.id.toString()] = marker;
//      }
//    });
//  }
//
//
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        home: Scaffold(
//        body: SafeArea(
//        child: Column(children: <Widget>[
//
//
//                Container(
//                  height: MediaQuery.of(context).size.height - 24,
//                  width: MediaQuery.of(context).size.width,
//                  child: Stack(children: <Widget>[
//
//                    GoogleMap(
//                      onMapCreated: _onMapCreated,
//                      initialCameraPosition: CameraPosition(
//                        target: const LatLng(0, 0),
//                        zoom: 6.0,
//                      ),
//                      markers: _markers.values.toSet(),
//                    ),
//
//
//                    Container(
//                      margin: EdgeInsets.only(
//                          top: MediaQuery.of(context).size.height - 320,
//                          right: 0,
//                          left: MediaQuery.of(context).size.width -
//                              MediaQuery.of(context).size.width / 4.8),
//                      child: Column(
//                        children: <Widget>[
//                          Container(
//                            height: MediaQuery.of(context).size.width / 6,
//                            width: MediaQuery.of(context).size.width / 6,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: new BorderRadius.only(
//                                  bottomRight: const Radius.circular(20.0),
//                                  topRight: const Radius.circular(20.0),
//                                  bottomLeft: const Radius.circular(20.0),
//                                  topLeft: const Radius.circular(20),
//                                ),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.black12.withOpacity(.1),
//                                      blurRadius: 2,
//                                      spreadRadius: 2),
//                                ]),
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Container(
//                            height: MediaQuery.of(context).size.width / 6,
//                            width: MediaQuery.of(context).size.width / 6,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: new BorderRadius.only(
//                                  bottomRight: const Radius.circular(20.0),
//                                  topRight: const Radius.circular(20.0),
//                                  bottomLeft: const Radius.circular(20.0),
//                                  topLeft: const Radius.circular(20),
//                                ),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.black12.withOpacity(.1),
//                                      blurRadius: 2,
//                                      spreadRadius: 2),
//                                ]),
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Container(
//                            height: MediaQuery.of(context).size.width / 6,
//                            width: MediaQuery.of(context).size.width / 6,
//                            decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: new BorderRadius.only(
//                                  bottomRight: const Radius.circular(20.0),
//                                  topRight: const Radius.circular(20.0),
//                                  bottomLeft: const Radius.circular(20.0),
//                                  topLeft: const Radius.circular(20),
//                                ),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.black12.withOpacity(.1),
//                                      blurRadius: 2,
//                                      spreadRadius: 2),
//                                ]),
//                          ),
//                        ],
//                      ),
//                    ),
//
//                    Container(
//                      margin: EdgeInsets.only(
//                          top: MediaQuery.of(context).size.height - 80,
//                          right: 20,
//                          left: MediaQuery.of(context).size.width / 3.2),
//                      height: MediaQuery.of(context).size.width / 8,
//                      width: MediaQuery.of(context).size.width,
//                      child: Row(
//                        children: <Widget>[
//                          Container(
//                            height: MediaQuery.of(context).size.width / 9,
//                            width: MediaQuery.of(context).size.width / 9,
//                            decoration: BoxDecoration(
//                              color: Colors.pinkAccent,
////              borderRadius: BorderRadius.all(Radius.circular(30)),
//
//                              borderRadius: new BorderRadius.only(
//                                bottomRight: const Radius.circular(10.0),
//                                topRight: const Radius.circular(30.0),
//                                bottomLeft: const Radius.circular(30.0),
//                                topLeft: const Radius.circular(30.0),
//                              ),
//                            ),
//                            child: Icon(
//                              Icons.favorite_border,
//                              size: 30,
//                              color: Colors.white,
//                            ),
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ),
//                          Container(
//                            height: MediaQuery.of(context).size.width / 9,
//                            width: MediaQuery.of(context).size.width / 9,
//                            decoration: BoxDecoration(
//                              color: Colors.green,
////              borderRadius: BorderRadius.all(Radius.circular(30)),
//
//                              borderRadius: new BorderRadius.only(
//                                bottomRight: const Radius.circular(10.0),
//                                topRight: const Radius.circular(30.0),
//                                bottomLeft: const Radius.circular(30.0),
//                                topLeft: const Radius.circular(30.0),
//                              ),
//                            ),
//                            child: Row(
//                              children: <Widget>[
//                                SizedBox(
//                                  width: 10,
//                                ),
//                                Icon(
//                                  Icons.settings,
//                                  size: 25,
//                                  color: Colors.white,
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(
//                            width: 10,
//                          ),
//                          Container(
//                            height: MediaQuery.of(context).size.width / 9,
//                            width: MediaQuery.of(context).size.width / 9,
//                            decoration: BoxDecoration(
//                              color: Colors.redAccent,
////              borderRadius: BorderRadius.all(Radius.circular(30)),
//
//                              borderRadius: new BorderRadius.only(
//                                bottomRight: const Radius.circular(10.0),
//                                topRight: const Radius.circular(30.0),
//                                bottomLeft: const Radius.circular(30.0),
//                                topLeft: const Radius.circular(30.0),
//                              ),
//                            ),
//                            child: Row(
//                              children: <Widget>[
//                                SizedBox(
//                                  width: 10,
//                                ),
//                                Icon(
//                                  Icons.delete,
//                                  size: 25,
//                                  color: Colors.white,
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ]),
//                ),
//              ]
//              )
//          )
//    ));
//  }
//}
//
//
//











//
//
//
//import 'package:flutter/material.dart';
//import 'package:web_socket_channel/io.dart';
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: WebSocketRoute(),
//    );
//  }
//}
//
//class WebSocketRoute extends StatefulWidget {
//  @override
//  _WebSocketRouteState createState() => new _WebSocketRouteState();
//}
//
//class _WebSocketRouteState extends State<WebSocketRoute> {
//  TextEditingController _controller = new TextEditingController();
//  IOWebSocketChannel channel;
//  String _text = "";
//
//
//  @override
//  void initState() {
//    //创建websocket连接
//    channel = new IOWebSocketChannel.connect('ws://192.168.1.7:8000/api/device/All_Device');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("WebSocket zebiii"),
//      ),
//      body: new Padding(
//        padding: const EdgeInsets.all(20.0),
//        child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            new Form(
//              child: new TextFormField(
//                controller: _controller,
//                decoration: new InputDecoration(labelText: 'Send a message'),
//              ),
//            ),
//            new StreamBuilder(
//              stream: channel.stream,
//              builder: (context, snapshot) {
//                //网络不通会走到这
//                if (snapshot.hasError) {
//                  _text = "网络不通...";
//                } else if (snapshot.hasData) {
//                  _text = "echo: "+snapshot.data;
//                }
//                return new Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 24.0),
//                  child: new Text(_text),
//                );
//              },
//            )
//          ],
//        ),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _sendMessage,
//        tooltip: 'Send message',
//        child: new Icon(Icons.send),
//      ),
//    );
//  }
//
//  void _sendMessage() {
//    if (_controller.text.isNotEmpty) {
//      channel.sink.add(_controller.text);
//    }
//  }
//
//  @override
//  void dispose() {
//    channel.sink.close();
//    super.dispose();
//  }
//}
//
//
//
//








import 'package:flutter/material.dart';
import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  final AnimatedQRViewController controller = AnimatedQRViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedQRView(
              squareColor: Colors.green.withOpacity(0.25),
              animationDuration: const Duration(milliseconds: 600),
              onScanBeforeAnimation: (String str) {
                print('Callback at the beginning of animation: $str');
              },
              onScan: (String str) async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Callback at the end of animation: $str'),
                    actions: [
                      FlatButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: Align(
                                  alignment: Alignment.center,
                                  child: Text('$str'),
                                ),
                              ),
                            ),
                          );
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: const Text('Flash'),
                  onPressed: () {
                    controller.toggleFlash();
                  },
                ),
                const SizedBox(width: 10),
                FlatButton(
                  color: Colors.blue,
                  child: const Text('Flip'),
                  onPressed: () {
                    controller.flipCamera();
                  },
                ),
                const SizedBox(width: 10),
                FlatButton(
                  color: Colors.blue,
                  child: const Text('Resume'),
                  onPressed: () {
                    controller.resume();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}