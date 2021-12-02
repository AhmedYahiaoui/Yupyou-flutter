import 'package:flutter/material.dart';
import 'package:front_v1/Pages/DevicePage/DeviceDetails.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key key, this.mainScreenAnimationController, this.mainScreenAnimation}) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<DetailView> with TickerProviderStateMixin {


  DatabaseHelper databaseHelper = new DatabaseHelper();
  PageController _pageController;
  int _selectedPage = 0;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(60.0),
                      bottomRight: Radius.circular(5.0),
                      topRight: Radius.circular(60.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[


//                            Container(
//                              height: double.infinity,
//                              width: double.infinity,
//
//                              child: PageView.builder(
//
//                                controller: _pageController,
//                                onPageChanged: (int index) {
//                                  setState(() {
//
//                                    _selectedPage = index;
//                                  });
//                                },
//                                itemCount: 1,
//                                itemBuilder: (BuildContext context, int index) {
//                                  return _plantSelector();
//                                },
//                              ),
//                            ),


                            FutureBuilder(
                              future: databaseHelper.getData(),
                              builder: (context, snapshot) {
                                final devices = snapshot.data;
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 2,
                                        color: Colors.black,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(devices[index]['title']),
                                        subtitle: Text('date pub: ${devices[index]['date_published']}'),
                                      );
                                    },
                                    itemCount: devices.length,
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),




//                            PageView.builder(
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

//
//                            FutureBuilder<List>(
//                              future: databaseHelper.getData(),
//                              builder: (context, snapshot) {
//                                if (snapshot.hasError) print(snapshot.error);
//                                return snapshot.hasData
//                                    ? new ItemList(list: snapshot.data)
//                                    : new Center(
//                                  child: new CircularProgressIndicator(
//                                    valueColor: new AlwaysStoppedAnimation<Color>(
//                                        AppTheme.nearlyDarkGeen),
//                                  ),
//                                );
//                              },
//                            ),



                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }






  _plantSelector() {
    return  GestureDetector(




        child: new FutureBuilder<List>(
          future: databaseHelper.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
                : new Center(
              child: new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    AppTheme.nearlyDarkGeen),
              ),
            );
          },
        )
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {

    return  new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {

          String imagechoice() {
            var grade = list[i]['category'];
            switch (grade) {
              case "humains":
                {
                  return 'assets/images/plant1.png';
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
          }
          IconData iconchoice() {
            var grade = list[i]['category'];
            switch (grade) {
              case "humains":
                {
                  return Icons.person_outline;
                }
                break;
              case "animals":
                {
                  return Icons.adb;
                }
                break;
              case "cars":
                {
                  return Icons.local_shipping;
                }
                break;
              case "objects":
                {
                  return Icons.child_friendly;
                }
                break;
            }
          }

          var slugg = list[i]['slug'];


          return new Container(

            padding: const EdgeInsets.all(7.0),
            child: new GestureDetector(



              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DeviceDetails(list:list, index:i,slugg:list[i]['slug'])
                  ),
                );
              },



              child: Stack(children: <Widget>[
                Positioned(
                    left: 200.0,
                    top: 25.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                        color: Colors.white,
                      ),
                      width: 175.0,
                      height: 180.0,
                      child: Column(
                        children: <Widget>[

                          SizedBox(height: 20.0),

                          Row(children: <Widget>[
                            new Flexible(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(list[i]['title'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                )),
                            SizedBox(width: 20.0),

                            Icon(iconchoice(),
                                size: 30, color:AppTheme.nearlyDarkGeen),
                          ]),

                          SizedBox(height: 20.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(" Category : ${list[i]['category']}",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),

                          SizedBox(height: 20.0),

                          Row(children: <Widget>[
                            new Flexible(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.access_time,
                                        size: 20, color: AppTheme.nearlyDarkGeen),

                                    Text(list[i]['date_published'],
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        )),

                                  ],
                                )),
                          ]
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Container(
                        width: 200.0,
                        height: 230.0,
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      )),

                ),
                Positioned(
                  child: Container(
                    width: 200.0,
                    height: 220.0,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imagechoice(),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });






  }
}