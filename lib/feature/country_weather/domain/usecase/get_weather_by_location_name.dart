

import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByLocationName {
  final WeatherRepository repository;

  GetWeatherByLocationName(this.repository);

  Future<Either<Failure,Weather>> call(String locationName) async {
    return await repository.getWeatherByLocationName(locationName);
  }

}