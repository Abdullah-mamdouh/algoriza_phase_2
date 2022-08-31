

import 'package:equatable/equatable.dart';

import 'condition_entity.dart';

class Hour extends Equatable  {

  //int? timeEpoch;
  String? time;
  double? tempC;
  double? tempF;
  //int? isDay;
  Condition? condition;
  // double? windMph;
  // double? windKph;
  // int? windDegree;
  // String? windDir;
  // int? pressureMb;
  // double? pressureIn;
  // int? precipMm;
  // int? precipIn;
  int? humidity;
  int? cloud;
  // double? feelslikeC;
  // double? feelslikeF;
  // double? windchillC;
  // double? windchillF;
  // double? heatindexC;
  // double? heatindexF;
  // double? dewpointC;
  // double? dewpointF;
  // int? willItRain;
  // int? chanceOfRain;
  // int? willItSnow;
  // int? chanceOfSnow;
  // int? visKm;
  // int? visMiles;
  // double? gustMph;
  // double? gustKph;
  // int? uv;

  Hour(
      {
        //this.timeEpoch,
        this.time,
        this.tempC,
        this.tempF,
        //this.isDay,
        this.condition,
        // this.windMph,
        // this.windKph,
        // this.windDegree,
        // this.windDir,
        // this.pressureMb,
        // this.pressureIn,
        // this.precipMm,
        // this.precipIn,
        this.humidity,
        this.cloud,
        // this.feelslikeC,
        // this.feelslikeF,
        // this.windchillC,
        // this.windchillF,
        // this.heatindexC,
        // this.heatindexF,
        // this.dewpointC,
        // this.dewpointF,
        // this.willItRain,
        // this.chanceOfRain,
        // this.willItSnow,
        // this.chanceOfSnow,
        // this.visKm,
        // this.visMiles,
        // this.gustMph,
        // this.gustKph,
        //this.uv
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
    time,
    tempC,
    tempF,
    condition,
    humidity,
    cloud,
  ];

}