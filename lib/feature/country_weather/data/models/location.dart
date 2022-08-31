

import 'package:flutter/cupertino.dart';
import 'package:weather_app/feature/country_weather/domain/entities/location_entity.dart';

class LocationModel extends Location {

  LocationModel({
    required String? name,
    required String? region,
    required String? country,
    required double? lat,
    required double? lon,
    required String? tzId,
    // required int? localtimeEpoch,
    required String? localtime,
}) : super(
    name: name,
    country: country,
    lat: lat,
    localtime: localtime,
    lon: lon,
    region: region,
    tzId: tzId,
  );



  factory LocationModel.fromJson(Map<String, dynamic> json) {
   // debugPrint(json.toString()+"lllllllllllllllllllllllllllllllllllllllllllllllll");
   return LocationModel(
       name: json['name'],
       region : json['region'],
    country : json['country'],
    lat : json['lat'],
    lon : json['lon'],
    tzId : json['tz_id'],
    // localtimeEpoch : json['localtime_epoch'],
    localtime : json['localtime'],
   );
  }

  Map<String, dynamic> toJson() {
    return {
    'name':name,
    'region':region,
    'country':country,
    'lat':lat,
    'lon':lon,
    'tz_id':tzId,
    // 'localtime_epoch':localtimeEpoch,
    'localtime':localtime,
    };

  }
}
