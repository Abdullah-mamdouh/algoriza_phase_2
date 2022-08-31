

import 'package:equatable/equatable.dart';

import 'condition_entity.dart';

class Current extends Equatable {

  // int? lastUpdatedEpoch;
  // String? lastUpdated;
  double? tempC;
  double? tempF;
  // int? isDay;
  Condition? condition;
  // double? windMph;
  double? windKph;
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
  // int? visKm;
  // int? visMiles;
  double? uv;
  // int? gustMph;
  // //double? gustKph;

  Current(
      {
        // this.lastUpdatedEpoch,
        // this.lastUpdated,
        this.tempC,
        this.tempF,
        // this.isDay,
        this.condition,
        //this.windMph,
        this.windKph,
        // this.windDegree,
        // this.windDir,
        // this.pressureMb,
        //this.pressureIn,
        // this.precipMm,
        // this.precipIn,
        this.humidity,
        this.cloud,
        //this.feelslikeC,
        //this.feelslikeF,
        // this.visKm,
        // this.visMiles,
        this.uv,
        // this.gustMph,
        //this.gustKph
      });

  @override
  List<Object?> get props => [tempF, tempC, condition, windKph, humidity, cloud,];


}