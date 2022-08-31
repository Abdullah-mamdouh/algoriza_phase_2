

import 'package:equatable/equatable.dart';

import 'forecast_of_day_entity.dart';

class Forecast extends Equatable {

  List<ForecastDay>? forecastday;

  Forecast({required this.forecastday});

  @override
  List<Object?> get props => [forecastday,];


}