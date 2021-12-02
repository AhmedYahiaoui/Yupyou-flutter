import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:charts_flutter/flutter.dart' as charts;


final DatabaseHelper2 databaseHelper = new DatabaseHelper2();

class PieChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Indicator(
                  color: const Color(0xff0293ee),
                  text: 'One',
                  isSquare: false,
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xfff8b250),
                  text: 'Two',
                  isSquare: false,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff845bef),
                  text: 'Three',
                  isSquare: false,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                ),
                Indicator(
                  color: const Color(0xff13d38e),
                  text: 'Four',
                  isSquare: false,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor: touchedIndex == 3 ? Colors.black : Colors.grey,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 12,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
          (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 65,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.55,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xff845bef).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 60,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.6,
            );
          case 3:
            return PieChartSectionData(
              color: const Color(0xff13d38e).withOpacity(opacity),
              value: 25,
              title: '',
              radius: 70,
              titleStyle: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xff0c7f55)),
              titlePositionPercentageOffset: 0.55,
            );
          default:
            return null;
        }
      },
    );
  }
}

/*
************************************* PIE CHART 2 ****************************
 */


class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}
class PieChart2State extends State {
  int touchedIndex;
//  List<int>DoubleList ;

  int hum = 0;
  int ani = 0;
  int obj = 0;
  int car = 0;
  int all = 0;

  @override
  void initState() {
    super.initState();
    funcThatMakesAsyncCall() ;
  }


  Future funcThatMakesAsyncCall() async {
    await databaseHelper.AllDeviceByUser().then((value){
      for (int i = 0; i < value.length; i++) {
        String t = value[i]['category'];

        switch (t) {
          case "human":
            {hum++;}
            break;
          case "animal":
            {ani++;}
            break;
          case "car":
            {car++ ;}
            break;
          case "object":
            {obj++ ;}
            break;
        }
        all ++;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'Humans',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Animals',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Cars',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Objects',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),

          ],
        ),
      ),
    );
  }



  List<PieChartSectionData> showingSections() {
    funcThatMakesAsyncCall();

    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 80 : 60;
      switch (i) {

        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: (hum / all * 100).toDouble(),
            title: ((hum / all*100).toDouble()).toStringAsFixed(2)+' %',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
//            value: double.parse(((DoubleList[1]/DoubleList[4]*100)).toStringAsFixed(2)),
            value: (ani / all*100).toDouble(),
            title: ((ani / all*100).toDouble()).toStringAsFixed(2)+' %',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: (car / all*100).toDouble(),
            title: ((car / all*100).toDouble()).toStringAsFixed(2)+' %',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: (obj / all*100).toDouble(),
            title: ((obj / all*100).toDouble()).toStringAsFixed(2)+' %',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );











        default:
          return null;
      }
    });
  }
}


/*
************************************* Indicator ****************************
 */





class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}


/*
*
* Chart
*
* */


