


import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/country_weather/data/models/weather.dart';

import '../../domain/entities/weather_entity.dart';

abstract class WeatherLocationState extends Equatable {
  const WeatherLocationState();

  @override
  List<Object> get props => [];
}

class WeatherLocationInitial extends WeatherLocationState {}

class LoadingWeatherLocationState extends WeatherLocationState {}

class LoadedWeatherLocationState extends WeatherLocationState {
  final Weather weatherLocation;

  LoadedWeatherLocationState({required this.weatherLocation});

  @override
  List<Object> get props => [weatherLocation];
}

class LoadedFavouriteWeatherLocationState extends WeatherLocationState {
  final List<Weather> favoriteWeatherLocations;

  LoadedFavouriteWeatherLocationState({required this.favoriteWeatherLocations});

  @override
  List<Object> get props => [favoriteWeatherLocations];
}

class LoadedOtherWeatherLocationState extends WeatherLocationState {
  final List<Weather> otherLocations;

  LoadedOtherWeatherLocationState({required this.otherLocations});

  @override
  List<Object> get props => [otherLocations];
}

class ErrorAddFavoriteLocationState extends WeatherLocationState {
  final String message;

  ErrorAddFavoriteLocationState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddFavoriteLocationState extends WeatherLocationState {
  final String message;

  MessageAddFavoriteLocationState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorWeatherLocationState extends WeatherLocationState {
  final String message;

  ErrorWeatherLocationState({required this.message});

  @override
  List<Object> get props => [message];
}
