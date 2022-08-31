
import 'package:flutter/cupertino.dart';

import '../../domain/entities/current_entity.dart';
import 'condition_weather.dart';

class CurrentModel extends Current {
  CurrentModel({
    // int? lastUpdatedEpoch,
    //String? lastUpdated,
    double? tempC,
    double? tempF,
    // int? isDay,
    ConditionModel? condition,
    //double? windMph,
    double? windKph,
    // int? windDegree,
    //String? windDir,
    // int? pressureMb,
    //double? pressureIn,
    // int? precipMm,
    // int? precipIn,
    int? humidity,
    int? cloud,
    // double? feelslikeC,
    // double? feelslikeF,
    // int? visKm,
    // int? visMiles,
    double? uv,
    // int? gustMph,
    //double? gustKph,
  }) : super(
            cloud: cloud,
            condition: condition,
            // feelslikeC: feelslikeC,
            // feelslikeF: feelslikeF,
            // gustKph: gustKph,
            //gustMph: gustMph,
            humidity: humidity,
            // isDay: isDay,
            //lastUpdated: lastUpdated,
            // lastUpdatedEpoch: lastUpdatedEpoch,
            // precipIn: precipIn,
            // precipMm: precipMm,
            // //pressureIn: pressureIn,
            // pressureMb: pressureMb,
            tempC: tempC,
            tempF: tempF,
            uv: uv,
            // visKm: visKm,
            // visMiles: visMiles,
            // windDegree: windDegree,
            //windDir: windDir,
            windKph: windKph,
            //windMph: windMph
  );


  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    //debugPrint(json.toString()+"ccccccccccccccccccccccccccccccccccccccccccccccccc");
   return CurrentModel(
    //lastUpdatedEpoch : json['last_updated_epoch'],
    //lastUpdated : json['last_updated'],
    tempC : json['temp_c'],
    tempF : json['temp_f'],
    //isDay : json['is_day'],
    condition : json['condition'] != null
        ? new ConditionModel.fromJson(json['condition'])
        : null,
    //windMph : json['wind_mph'],
    windKph : json['wind_kph'],
    //windDegree : json['wind_degree'],
    //windDir : json['wind_dir'],
    //pressureMb : json['pressure_mb'],
    //pressureIn : json['pressure_in'],
    // precipMm : json['precip_mm'],
    // precipIn : json['precip_in'],
    humidity : json['humidity'],
    cloud : json['cloud'],
    // feelslikeC : json['feelslike_c'],
    // feelslikeF : json['feelslike_f'],
    // visKm : json['vis_km'],
    // visMiles : json['vis_miles'],
    uv : json['uv'],
    // gustMph : json['gust_mph'],
    //gustKph : json['gust_kph'],
    );
  }

  Map<String, dynamic> toJson() {
   return {
    //   'last_updated_epoch': lastUpdatedEpoch,
    // 'last_updated': lastUpdated,
    'temp_c': tempC,
    'temp_f': tempF,
    // 'is_day': isDay,

    'condition': condition,
    //'wind_mph': windMph,
    'wind_kph': windKph,
    // 'wind_degree': windDegree,
    // 'wind_dir': windDir,
    // 'pressure_mb': pressureMb,
    // //'pressure_in': pressureIn,
    // 'precip_mm': precipMm,
    // 'precip_in': precipIn,
    'humidity': humidity,
    'cloud': cloud,
    // 'feelslike_c': feelslikeC,
    // 'feelslike_f': feelslikeF,
    // 'vis_km': visKm,
    // 'vis_miles': visMiles,
    'uv': uv,
    // 'gust_mph': gustMph,
    //'gust_kph': gustKph,
  };
  }
}
