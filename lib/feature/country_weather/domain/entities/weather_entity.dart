
import 'package:equatable/equatable.dart';

import 'current_entity.dart';
import 'forecast_entity.dart';
import 'location_entity.dart';

class Weather extends Equatable {

  Location? location;
  Current? current;
  Forecast? forecast;
  Weather({required this.location, required this.forecast, required this.current});

  @override
  List<Object?> get props => [location, current, forecast];

}