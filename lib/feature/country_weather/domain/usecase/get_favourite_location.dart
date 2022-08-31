

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failuers.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/country_weather/domain/repositories/weather_repository.dart';

class GetFavoriteLocation {
  final WeatherRepository repository;

  GetFavoriteLocation(this.repository);

  Future<Either<Failure, List<Weather>>> call() async {
    return await repository.getFavoriteLocation();
  }

}