// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevicesDataAndLocation _$DevicesDataAndLocationFromJson(
    Map<String, dynamic> json) {
  return DevicesDataAndLocation(
      dismantled: json['dismantled'] as int,
      moving: json['moving'] as int,
      charging: json['charging'] as int,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      voltage: json['voltage'] as int,
      LAT: (json['LAT'] as num)?.toDouble(),
      LNG: (json['LNG'] as num)?.toDouble(),
      batterie: (json['batterie'] as num)?.toDouble());
}

Map<String, dynamic> _$DevicesDataAndLocationToJson(
        DevicesDataAndLocation instance) =>
    <String, dynamic>{
      'dismantled': instance.dismantled,
      'moving': instance.moving,
      'charging': instance.charging,
      'voltage': instance.voltage,
      'LAT': instance.LAT,
      'LNG': instance.LNG,
      'batterie': instance.batterie,
      'time': instance.time?.toIso8601String()
    };

Devices _$DevicesFromJson(Map<String, dynamic> json) {
  return Devices(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      author: json['author'] as int,
      date_published: json['date_published'] == null
          ? null
          : DateTime.parse(json['date_published'] as String),
      favorit: json['favorit'] as bool,
      datas: (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : DevicesDataAndLocation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DevicesToJson(Devices instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'author': instance.author,
      'date_published': instance.date_published?.toIso8601String(),
      'favorit': instance.favorit,
      'datas': instance.datas
    };

LocationsAndDataOfDevice _$LocationsAndDataOfDeviceFromJson(
    Map<String, dynamic> json) {
  return LocationsAndDataOfDevice(
      Deviceslocations: (json['Deviceslocations'] as List)
          ?.map((e) => e == null
              ? null
              : DevicesDataAndLocation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LocationsAndDataOfDeviceToJson(
        LocationsAndDataOfDevice instance) =>
    <String, dynamic>{'Deviceslocations': instance.Deviceslocations};

DevicesAndDataLocations _$DevicesAndDataLocationsFromJson(
    Map<String, dynamic> json) {
  return DevicesAndDataLocations(
      devices: (json['devices'] as List)
          ?.map((e) =>
              e == null ? null : Devices.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DevicesAndDataLocationsToJson(
        DevicesAndDataLocations instance) =>
    <String, dynamic>{'devices': instance.devices};
