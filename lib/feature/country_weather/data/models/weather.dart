import 'package:weather_app/feature/country_weather/data/models/location.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';

import 'condition_weather.dart';
import 'current_weather.dart';
import 'forecast.dart';

class WeatherModel extends Weather{
  WeatherModel({
    required LocationModel? location,
    required CurrentModel? current,
    required ForecastModel? forecast
  }) : super(current: current, forecast: forecast, location: location);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        location: LocationModel.fromJson(json['location']),
        current: CurrentModel.fromJson(json['current']),
        forecast: ForecastModel.fromJson(json['forecast'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'current': current,
      'forecast': forecast,
    };
  }


}
