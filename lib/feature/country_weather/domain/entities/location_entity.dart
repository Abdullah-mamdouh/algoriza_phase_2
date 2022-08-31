

import 'package:equatable/equatable.dart';

class Location extends Equatable {

  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  //int? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
        this.region,
        this.country,
        this.lat,
        this.lon,
        this.tzId,
        //this.localtimeEpoch,
        this.localtime});


  @override

  List<Object?> get props => [name, region, country, lat, lon, tzId, localtime];

}