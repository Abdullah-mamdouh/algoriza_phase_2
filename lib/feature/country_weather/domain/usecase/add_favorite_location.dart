

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failuers.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/country_weather/domain/repositories/weather_repository.dart';

class AddFavoriteLocation {
  final WeatherRepository repository;

  AddFavoriteLocation(this.repository);

  Future<Either<Failure, Unit>> call(String locationName) async {
    return await repository.addfavoriteLocation(locationName);
  }

}