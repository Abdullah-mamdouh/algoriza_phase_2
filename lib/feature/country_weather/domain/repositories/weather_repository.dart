
import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {

  Future<Either<Failure, Weather>> getWeatherByLocationName(String locationName);

  Future<Either<Failure, Weather>> getCurrentWeatherLocation();

  Future<Either<Failure, Unit>> addfavoriteLocation(String locationName);
  Future<Either<Failure, List<Weather>>> getFavoriteLocation();

  Future<Either<Failure, Unit>> addToOtherLocation(String locationName);
  Future<Either<Failure, List<Weather>>> getOtherLocation();
  }