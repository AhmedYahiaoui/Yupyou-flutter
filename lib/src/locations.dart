import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locations.g.dart';

@JsonSerializable()
class Deviceslocation {
  Deviceslocation({
    this.id,
    this.lat,
    this.lng,
    this.x_acc,
    this.y_acc,
    this.z_acc,
    this.battery,
    this.date_updated,
  });

  factory Deviceslocation.fromJson(Map<String, dynamic> json) => _$DeviceslocationFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceslocationToJson(this);

  final int id;
  final double lat;
  final double lng;
  final double x_acc;
  final double y_acc;
  final double z_acc;
  final double battery;
  final DateTime date_updated;
}


@JsonSerializable()
class Devices {
  Devices({
    this.id,
    this.title,
    this.category,
    this.author_id,
    this.date_published,
    this.slug,
    this.favorit,
    this.datas,
  });

  factory Devices.fromJson(Map<String, dynamic> json) => _$DevicesFromJson(json);
  Map<String, dynamic> toJson() => _$DevicesToJson(this);

  final int id ;
  final String title ;
  final String category ;
  final int author_id ;
  final DateTime date_published ;
  final String slug ;
  final bool favorit ;
  final List <Deviceslocation> datas ;

//  Devices({this.id, this.title, this.category, this.author_id, this.date_published, this.slug, this.favorit, this.datas});

//  factory Devices.fromJson(Map<String, dynamic> json) {
//    return Devices(
//      id: json['id'],
//      title: json['title'],
//      category: json['category'],
//      author_id: json['author_id'],
//      date_published: json['date_published'],
//      slug: json['slug'],
//      favorit: json['favorit'],
////      datas: Address.json['is_active'],
//    );
//  }
}





@JsonSerializable()
class LocationsDevices {
  final List<Deviceslocation> Deviceslocations;
  LocationsDevices({
    this.Deviceslocations,
  });

//  factory LocationsDevices.fromJson(Map<String, dynamic> json) =>
//      _$LocationsDevicesFromJson(json);
//  Map<String, dynamic> toJson() => _$LocationsDevicesToJson(this);
//  final List<Deviceslocation> Deviceslocations;
  factory LocationsDevices.fromJson(List<dynamic> parsedJson) {
    List<Deviceslocation> Deviceslocations = new List<Deviceslocation>();
    Deviceslocations = parsedJson.map((i)=>Deviceslocation.fromJson(i)).toList();
    return new LocationsDevices(
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