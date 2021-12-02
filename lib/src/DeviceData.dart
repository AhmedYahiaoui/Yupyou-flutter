import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'DeviceData.g.dart';





@JsonSerializable()
class DevicesDataAndLocation {
  DevicesDataAndLocation({
    this.dismantled,
    this.moving,
    this.charging,
    this.time,
    this.voltage,
    this.LAT,
    this.LNG,
    this.batterie,
  });

  factory DevicesDataAndLocation.fromJson(Map<String, dynamic> json) => _$DevicesDataAndLocationFromJson(json);
  Map<String, dynamic> toJson() => _$DevicesDataAndLocationToJson(this);

  final int dismantled;
  final int moving;
  final int charging;
  final int voltage;
  final double LAT;
  final double LNG;
  final double batterie;
  final DateTime time;
}



@JsonSerializable()
class Devices {
  Devices({
    this.id,
    this.title,
    this.category,
    this.author,
    this.date_published,
    this.favorit,
    this.datas,
  });

  factory Devices.fromJson(Map<String, dynamic> json) => _$DevicesFromJson(json);
  Map<String, dynamic> toJson() => _$DevicesToJson(this);

  final int id ;
  final String title ;
  final String category ;
  final int author ;
  final DateTime date_published ;
  final bool favorit ;
  final List <DevicesDataAndLocation> datas ;

}




@JsonSerializable()
class LocationsAndDataOfDevice {
  final List<DevicesDataAndLocation> Deviceslocations;
  LocationsAndDataOfDevice({
    this.Deviceslocations,
  });

  factory LocationsAndDataOfDevice.fromJson(List<dynamic> parsedJson) {
    List<DevicesDataAndLocation> Deviceslocations =  List<DevicesDataAndLocation>();
    Deviceslocations = parsedJson.map((i)=>DevicesDataAndLocation.fromJson(i)).toList();
    return  LocationsAndDataOfDevice(
        Deviceslocations: Deviceslocations);
  }
}



@JsonSerializable()
class DevicesAndDataLocations {

  final List<Devices> devices;

  // ignore: sort_constructors_first
  DevicesAndDataLocations({
    this.devices,
  });

  // ignore: sort_constructors_first
  factory DevicesAndDataLocations.fromJson(List<dynamic> parsedJson) {
    List<Devices> devices =  List<Devices>();
    devices = parsedJson.map((i)=>Devices.fromJson(i)).toList();
    return DevicesAndDataLocations(
      devices:devices,
    );
  }
}













/*
*
* *************************************************************************
*
* */














//List<Devices_obj> deviceFromJson(String str) =>
//    List<Devices_obj>.from(json.decode(str).map((x) => Devices_obj.fromJson(x)));
//
//String deviceToJson(List<Devices_obj> data) =>
//    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//
//
//
//
//
//class Devices_obj {
//  String id;
//  List<DeviceDatum> deviceData;
//  String title;
//  bool favorit;
//  String ref;
//  String datePublished;
//  String category;
//
//
//  Devices_obj ({
//    this.title,
//    this.datePublished,
//    this.category,
//    this.id,
//    this.ref,
//    this.favorit,
//    this.deviceData,
//  });
//
//  factory Devices_obj.fromJson(Map<String, dynamic> json) => Devices_obj(
//        title: json["title"],
//        datePublished: json["date_published"],
//        category: json["category"],
//        id: json["id"],
//        ref: json["ref"],
//        favorit: json["favorit"],
////        deviceData: List<DeviceDatum>.from(
////            json["device_data"].map((x) => DeviceDatum.fromJson(x))),
//
//        deviceData: parseDatas(json)
//
//
//  );
//
//
//  static List<DeviceDatum> parseDatas(DatasJson) {
//    var list = DatasJson['DeviceDatum'] as List;
//    List<DeviceDatum> DataList =
//    list.map((data) => DeviceDatum.fromJson(data)).toList();
//    return DataList;
//  }
//
//  Map<String, dynamic> toJson() => {
//        "title": title,
//        "date_published": datePublished.toIso8601String(),
//        "image": image,
//        "category": category,
//        "id": id,
//        "slug": slug,
//        "ref": ref,
//        "favorit": favorit,
//        "device_data": List<dynamic>.from(deviceData.map((x) => x.toJson())),
//      };
//}
//
//
//
//
//
//
//@JsonSerializable()
//class Device {
//  final String title;
//  final DateTime datePublished;
//  final String category;
//  final int id;
//  final String slug;
//  final String ref;
//  final bool favorit;
//
//  @JsonKey(nullable: false)
//  List<DeviceDatum> datas;
//
//
//
//
//  Device({this.title, this.datePublished, this.category, this.id,
//  this.slug, this.ref, this.favorit,  List<DeviceDatum> datas})
//      : datas = datas ?? <DeviceDatum>[];
//  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
//  Map<String, dynamic> toJson() => _$DeviceToJson(this);
//}
//
//@JsonSerializable(includeIfNull: false)
//class DeviceDatum {
//  int id;
//  int deviceId;
//  double lat;
//  double lng;
//  int xAcc;
//  int yAcc;
//  int zAcc;
//  int battery;
//  DateTime dateUpdated;
//
//  DeviceDatum({
//    this.id,
////    this.deviceId,
//    this.lat,
//    this.lng,
//    this.xAcc,
//    this.yAcc,
//    this.zAcc,
//    this.battery,
//    this.dateUpdated,
//  });
//
//  factory DeviceDatum.fromJson(Map<String, dynamic> json) => _$DeviceDatumFromJson(json);
//
//  Map<String, dynamic> toJson() => _$DeviceDatumToJson(this);
//
//
////  factory DeviceDatum.fromJson(Map<String, dynamic> json) => DeviceDatum(
////    id: json["id"],
//////    deviceId: json["device_id"],
////    lat: json["lat"].toDouble(),
////    lng: json["lng"].toDouble(),
////    xAcc: json["x_acc"],
////    yAcc: json["y_acc"],
////    zAcc: json["z_acc"],
////    battery: json["battery"],
////    dateUpdated: DateTime.parse(json["date_updated"]),
////  );
////
////  Map<String, dynamic> toJson() => {
////    "id": id,
//////    "device_id": deviceId,
////    "lat": lat,
////    "lng": lng,
////    "x_acc": xAcc,
////    "y_acc": yAcc,
////    "z_acc": zAcc,
////    "battery": battery,
////    "date_updated": dateUpdated.toIso8601String(),
////  };
//}
//
////@JsonSerializable()
////class DevicesDataLocations {
////
////  final List<Device> devices;
////
////  // ignore: sort_constructors_first
////  DevicesDataLocations({
////    this.devices,
////  });
////
////  // ignore: sort_constructors_first
////  factory DevicesDataLocations.fromJson(List<dynamic> parsedJson) {
////    List<Device> devices =  List<Device>();
////    devices = parsedJson.map((i)=>Device.fromJson(i)).toList();
////    return DevicesDataLocations(
////      devices:devices,
////    );
////  }
////}
//
//@JsonSerializable()
//class DevicesDataLocations {
//  final List<Device> devices;
//  DevicesDataLocations({
//    this.devices,
//  });
//
////  factory LocationsDevices.fromJson(Map<String, dynamic> json) =>
////      _$LocationsDevicesFromJson(json);
////  Map<String, dynamic> toJson() => _$LocationsDevicesToJson(this);
////  final List<Deviceslocation> Deviceslocations;
//  factory DevicesDataLocations.fromJson(List<dynamic> parsedJson) {
//    List<Device> devices = new List<Device>();
//    devices = parsedJson.map((i)=>Device.fromJson(i)).toList();
//    return new DevicesDataLocations(
//        devices: devices);
//  }
//}
