

import 'package:equatable/equatable.dart';

import 'condition_entity.dart';

class Day extends Equatable {

  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindMph;
  double? maxwindKph;
  // int? totalprecipMm;
  // int? totalprecipIn;
  // int? avgvisKm;
  // int? avgvisMiles;
  // int? avghumidity;
  // int? dailyWillItRain;
  // int? dailyChanceOfRain;
  // int? dailyWillItSnow;
  // int? dailyChanceOfSnow;
  Condition? condition;
  int? uv;

  Day(
      {this.maxtempC,
        this.maxtempF,
        this.mintempC,
        this.mintempF,
        this.avgtempC,
        this.avgtempF,
        this.maxwindMph,
        this.maxwindKph,
        // this.totalprecipMm,
        // this.totalprecipIn,
        // this.avgvisKm,
        // this.avgvisMiles,
        // this.avghumidity,
        // this.dailyWillItRain,
        // this.dailyChanceOfRain,
        // this.dailyWillItSnow,
        // this.dailyChanceOfSnow,
        this.condition,
        this.uv});

  @override
  // TODO: implement props
  List<Object?> get props => [
    maxtempC,
    maxtempF,
    mintempC,
    mintempF,
    avgtempC,
    avgtempF,
    maxwindMph,
    maxwindKph,
    condition,
    uv];

}