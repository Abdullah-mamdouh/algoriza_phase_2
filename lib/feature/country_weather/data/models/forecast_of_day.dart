


import 'package:flutter/cupertino.dart';
import 'package:weather_app/feature/country_weather/data/models/hour.dart';

import '../../domain/entities/forecast_of_day_entity.dart';
import 'astro.dart';
import 'day.dart';

class ForecastdayModel extends ForecastDay{

  ForecastdayModel({
    required String? date,
    //required int? dateEpoch,
    required DayModel? day,
    required AstroModel? astro,
    required List<HourModel>? hour,
  }): super(
    date: date,
    astro: astro,
    day: day,
    hour: hour,
  );

  factory ForecastdayModel.fromJson(Map<String, dynamic> json) {

    final List<HourModel> hourslist= [];
    json['hour'].forEach((v) {
      hourslist.add( HourModel.fromJson(v));
      //debugPrint(hourslist.toList().toString()+'aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    });
    //debugPrint("----> forecastdayModel <-----" +json.toString());
    return ForecastdayModel
      (date: json['date'], //dateEpoch: json['date_epoch'],
        day: DayModel.fromJson(json['day']),
        astro: AstroModel.fromJson(json['astro']),
        hour: hourslist,//json['hour'],
    );


  }

  Map<String, dynamic> toJson() {
    return {
    'date':date,
    //'date_epoch':dateEpoch,
    'day':day,
    'astro':astro,
    //'hour':hour!.map((v) => v.toJson()).toList(),
    };


  }
}
