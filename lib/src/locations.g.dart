// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deviceslocation _$DeviceslocationFromJson(Map<String, dynamic> json) {
  return Deviceslocation(
      id: json['id'] as int,
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble(),
      x_acc: (json['x_acc'] as num)?.toDouble(),
      y_acc: (json['y_acc'] as num)?.toDouble(),
      z_acc: (json['z_acc'] as num)?.toDouble(),
      battery: (json['battery'] as num)?.toDouble(),
      date_updated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String));
}

Map<String, dynamic> _$DeviceslocationToJson(Deviceslocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'x_acc': instance.x_acc,
      'y_acc': instance.y_acc,
      'z_acc': instance.z_acc,
      'battery': instance.battery,
      'date_updated': instance.date_updated?.toIso8601String()
    };

Devices _$DevicesFromJson(Map<String, dynamic> json) {
  return Devices(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      author_id: json['author_id'] as int,
      date_published: json['date_published'] == null
          ? null
          : DateTime.parse(json['date_published'] as String),
      slug: json['slug'] as String,
      favorit: json['favorit'] as bool,
      datas: (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : Deviceslocation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DevicesToJson(Devices instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'author_id': instance.author_id,
      'date_published': instance.date_published?.toIso8601String(),
      'slug': instance.slug,
      'favorit': instance.favorit,
      'datas': instance.datas
    };

LocationsDevices _$LocationsDevicesFromJson(Map<String, dynamic> json) {
  return LocationsDevices(
      Deviceslocations: (json['Deviceslocations'] as List)
          ?.map((e) => e == null
              ? null
              : Deviceslocation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LocationsDevicesToJson(LocationsDevices instance) =>
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
