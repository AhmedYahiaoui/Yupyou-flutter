import 'dart:ffi';

class Devices {

  final int id ;
  final String title ;
  final String category ;
  final int author_id ;
  final String date_published ;

  Devices.fromJSON(Map<String,dynamic> jsonMap):
        id = jsonMap['id'],
        title = jsonMap['title'],
        category = jsonMap['category'],
        author_id = jsonMap['author_id'],
        date_published = jsonMap['date_published'];

}




class Datas {
  final int id ;
  final Float lat ;
  final Float lng ;
  final Float x_acc ;
  final Float y_acc ;
  final Float z_acc ;
  final Float battery ;
  final DateTime date_updated ;

  Datas({this.id, this.lat, this.lng, this.x_acc, this.y_acc, this.z_acc,this.battery, this.date_updated});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
        id : json['id'],
        lat : json['lat'],
        lng : json['lng'],
        x_acc : json['x_acc'],
        y_acc : json['y_acc'],
        z_acc : json['z_acc'],
        battery : json['battery'],
        date_updated : json['date_updated'],
    );
  }
}

class Device {
  final int id ;
  final String title ;
  final String category ;
  final int author_id ;
  final String date_published ;
  final String slug ;
  final bool favorit ;

  Device({this.id, this.title, this.category, this.author_id, this.date_published, this.slug, this.favorit});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      author_id: json['author_id'],
      date_published: json['date_published'],
      slug: json['slug'],
      favorit: json['favorit'],
//      datas: Address.json['is_active'],
    );
  }
}
