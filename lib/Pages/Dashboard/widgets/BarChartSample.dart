import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:intl/intl.dart';

final DatabaseHelper2 databaseHelper = new DatabaseHelper2();

class BarChartSample extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample> {
  final Color barBackgroundColor = Colors.black;
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;
  bool isPlaying = false;



  /*
  *
  * RestFull
  *
  * */

  List<int>DoubleList ;
  int jn = 0;
  int fv = 0;
  int mr = 0;
  int av = 0;
  int ma = 0;
  int ju = 0;
  int jl = 0;
  int au = 0;
  int sp = 0;
  int oc = 0;
  int nv = 0;
  int dc = 0;


  @override
  void initState() {
    super.initState();
    funcThatMakesAsyncCall() ;
  }


  Future funcThatMakesAsyncCall() async {
    await databaseHelper.AllDeviceByUser().then((value){
      for (int i = 0; i < value.length; i++) {

//        DateTime tempDate = DateFormat("yyyy-MM-dd").parse(value[i]['date_published']);
//        DateTime tempDates =  DateFormat("yyyy-MM-dd hh:mm:s").parse(value[i]['date_published']);

//        String date = value[i]['date_published'];
//        String date = value[i]['date_published'];
//        String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
//        DateTime dateTime =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateWithT);

        String t = value[i]['date_published'];
        var int2 = int.tryParse(t);
        var date = DateTime.fromMillisecondsSinceEpoch(int2);

        String newDt = DateFormat.MMMM().format(date);

        switch (newDt) {

          case "January":
            {
               jn++;
            }
            break;
          case "February":
            {
               fv++;
            }
            break;
          case "March":
            {
               mr++ ;
            }
            break;
          case "April":
            {
               av++ ;
            }
            break;
          case "May":
            {
               ma++ ;
            }
            break;
          case "June":
            {
               ju++ ;
            }
            break;
          case "July":
            {
               jl++ ;
            }
            break;
          case "August":
            {
               au++ ;
            }
            break;
          case "September":
            {
               sp++ ;
            }
            break;
          case "October":
            {
               oc++ ;
            }
            break;
          case "November":
            {
               nv++ ;
            }
            break;
          case "December":
            {
               dc++ ;
            }
            break;
        }



      }
    });
  }



  /*
  *
  * RestFull
  *
  * */



  @override
  Widget build(BuildContext context)  {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//        color: const Color(0xff81e5cd),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = AppTheme.nearlyDarkGeen,
        double width = 5,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 10,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
//    funcThatMakesAsyncCall();
    switch (i) {
      case 0:
        return makeGroupData(0, jn.toDouble() , isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, fv.toDouble() , isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, mr.toDouble() , isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, av.toDouble() , isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, ma.toDouble() , isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5, ju.toDouble() , isTouched: i == touchedIndex);
      case 6:
        return makeGroupData(6, jl.toDouble() , isTouched: i == touchedIndex);
      case 7:
        return makeGroupData(7, au.toDouble() , isTouched: i == touchedIndex);
      case 8:
        return makeGroupData(8, sp.toDouble() , isTouched: i == touchedIndex);
      case 9:
        return makeGroupData(9, oc.toDouble() , isTouched: i == touchedIndex);
      case 10:
        return makeGroupData(10, nv.toDouble() , isTouched: i == touchedIndex);
      case 11:
        return makeGroupData(11, dc.toDouble() , isTouched: i == touchedIndex);

      default:
        return null;
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'January';
                  break;
                case 1:
                  weekDay = 'February';
                  break;
                case 2:
                  weekDay = 'March';
                  break;
                case 3:
                  weekDay = 'April';
                  break;
                case 4:
                  weekDay = 'May';
                  break;
                case 5:
                  weekDay = 'June';
                  break;
                case 6:
                  weekDay = 'July';
                  break;
                case 7:
                  weekDay = 'August';
                  break;
                case 8:
                  weekDay = 'September';
                  break;
                case 9:
                  weekDay = 'October';
                  break;
                case 10:
                  weekDay = 'November';
                  break;
                case 11:
                  weekDay = 'December';
                  break;

              }
              return BarTooltipItem(
                  weekDay + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: AppTheme.nearlyDarkGeen, fontWeight: FontWeight.bold, fontSize: 10),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'J';
              case 1:
                return 'F';
              case 2:
                return 'M';
              case 3:
                return 'A';
              case 4:
                return 'M';
              case 5:
                return 'J';
              case 6:
                return 'J';
              case 7:
                return 'A';
              case 8:
                return 'S';
              case 9:
                return 'O';
              case 10:
                return 'N';
              case 11:
                return 'D';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }




  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'J';
              case 1:
                return 'F';
              case 2:
                return 'M';
              case 3:
                return 'A';
              case 4:
                return 'M';
              case 5:
                return 'J';
              case 6:
                return 'J';
              case 7:
                return 'A';
              case 8:
                return 'S';
              case 9:
                return 'O';
              case 10:
                return 'N';
              case 11:
                return 'D';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 8,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),
    );
  }





  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
