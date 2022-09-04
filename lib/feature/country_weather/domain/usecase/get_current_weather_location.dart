


import 'package:dartz/dartz.dart';

import '../../../../core/error/failuers.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherLocation {
  final WeatherRepository repository;

  GetCurrentWeatherLocation(this.repository);

  Future<Either<Failure,Weather>> call() async {
    return await repository.getCurrentWeatherLocation();
  }

}