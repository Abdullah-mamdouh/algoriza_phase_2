

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failuers.dart';
import 'package:weather_app/feature/country_weather/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/country_weather/domain/repositories/weather_repository.dart';

import '../../../../core/network/network_info.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource weatherDataSource;
  final NetworkInfo networkInfo;
  WeatherRepositoryImpl({required this.weatherDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, Unit>> addfavoriteLocation(String locationName) async {

      await weatherDataSource.addFavoriteLocation(locationName);
      return Right(unit);
    }

  @override
  Future<Either<Failure, Weather>> getWeatherByLocationName(String locationName) async{
    if (await networkInfo.isConnected) {
      try{
        final locationWeatherModel = await weatherDataSource.getWeatherByLocationName(locationName);
        //Weather locationWeather = Weather(location: locationWeatherModel.location!, forecast: locationWeatherModel.forecast!, current: locationWeatherModel.current!);
        return Right(locationWeatherModel);
      }on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }

  }

  @override
  Future<Either<Failure, List<Weather>>> getFavoriteLocation() async{
    if (await networkInfo.isConnected) {
      try{
        final favoriteLocations = await weatherDataSource.getFavoriteLocation();
        return Right(favoriteLocations);
      }on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getCurrentWeatherLocation() async{
    if (await networkInfo.isConnected) {
      try{
        final locationWeatherModel = await weatherDataSource.getCurrentWeatherLocation();
        //Weather locationWeather = Weather(location: locationWeatherModel.location!, forecast: locationWeatherModel.forecast!, current: locationWeatherModel.current!);
        return Right(locationWeatherModel);
      }on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToOtherLocation(String locationName) async {
    await weatherDataSource.addAnotherLocation(locationName);
    return Right(unit);
  }

  @override
  Future<Either<Failure, List<Weather>>> getOtherLocation() async{
    if (await networkInfo.isConnected) {
      try{
        final otherLocations = await weatherDataSource.getOtherLocation();
        return Right(otherLocations);
      }on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }


}