

import 'package:equatable/equatable.dart';

import 'astro_entity.dart';
import 'day_entity.dart';
import 'hour_entity.dart';

class ForecastDay extends Equatable {
  String? date;
  // int? dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  ForecastDay({this.date,
    //this.dateEpoch,
    this.day, this.astro, this.hour});

  @override
  // TODO: implement props
  List<Object?> get props => [date, day, astro, hour];

}