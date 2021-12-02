import 'package:flutter/material.dart';
import 'package:front_v1/Models/Device.dart';
import 'package:front_v1/Pages/Dashboard/widgets/title_view.dart';
import 'package:front_v1/Pages/DevicePage/DeviceDetails.dart';
import 'package:front_v1/Pages/DevicePage/testFile.dart';
import 'package:front_v1/Pages/DevicePage/widgets/category_view.dart';
import 'package:front_v1/Service/DatabaseHelper.dart';
import 'package:front_v1/Theme/app_theme.dart';

class DeviceSc extends StatefulWidget {


  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<DeviceSc> {
  List<Devices>_devices = <Devices>[];


  DatabaseHelper databaseHelper = new DatabaseHelper();


  @override
  void initState() {
    super.initState();
    listenForDevices();
  }

  void listenForDevices () async
  {
//    final Stream<Devices> stream = await databaseHelper.getDevices();
//    stream.listen((Devices devices) =>
//        setState(() => _devices.add(devices))
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          itemCount: _devices.length,
            itemBuilder: (context,index ){
            return Row (
              children: <Widget>[
                Text(_devices[index].title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            );
            },
        ),
      ),
    );
  }
}
