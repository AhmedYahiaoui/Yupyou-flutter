import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';


class ShowDetails extends StatefulWidget {

  List list;
  int index;
  ShowDetails({this.index , this.list}) ;


  @override
  _PlantScreenState createState() => _PlantScreenState();

}

class _PlantScreenState extends State<ShowDetails> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  IconData iconchoice() {
    var grade = widget.list[widget.index]['category'];
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


  String imagechoice() {
    var grade = widget.list[widget.index]['category'];
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
                    height: 520.0,
                    color: Color(0xFF32A060),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart,
                              size: 30.0,
                              color: Colors.white,
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
                    right: 20.0,
                    bottom: 30.0,
                    child: Hero(
                      tag: imagechoice(),
                      child: Image(
                        height: 280.0,
                        width: 280.0,
                        image: AssetImage(imagechoice()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


//                  Positioned(
//                    right: 20.0,
//                    bottom: 30.0,
//                    child: Hero(
//                      tag:"DemoTag",
//                      child: Image(
//                        height: 280.0,
//                        width: 280.0,
//                        image: AssetImage(imagechoice()),
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ),







//
//                  Hero(
//                      tag:"btn1",
//                      child: Image(
//                        height: 280.0,
//                        width: 280.0,
//                        image: AssetImage(
//                          imagechoice(),
//                        ),
//                        fit: BoxFit.cover,
//                      ),
//                    ),






                ],
              ),


              Container(
                height: 400.0,
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
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
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
                            widget.list[widget.index]['title'],
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,

                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            widget.list[widget.index].toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          Text(
                            'Nursery pot width: 12cm',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),

                          Text(
                            widget.list[widget.index]['slug'],
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
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
