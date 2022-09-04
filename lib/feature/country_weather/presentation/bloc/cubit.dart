

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/add_favorite_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/add_to_other_locations.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_current_weather_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_favourite_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_other_locations.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_weather_by_location_name.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/states.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/strings/messages.dart';
import '../../domain/entities/weather_entity.dart';

class AppBloc extends Cubit<WeatherLocationState> {
  final GetWeatherByLocationName getWeatherByLocationName;
  final AddFavoriteLocation addFavoriteLocation;
  final GetFavoriteLocation getFavoriteLocation;
  final GetCurrentWeatherLocation getCurrentWeatherLocation;
  final AddToOtherLocations addToOtherLocations;
  final GetOtherLocations getOtherLocations;

  static List<Weather> favoriteLocations = [];
  static List<Weather> otherWeatherLocations = [];
  static Weather? currentLocation ;
  AppBloc({
    required this.getWeatherByLocationName,
    required this.getCurrentWeatherLocation,
    required this.addFavoriteLocation,
    required this.getFavoriteLocation,
    required this.getOtherLocations,
    required this.addToOtherLocations
  }) : super(WeatherLocationInitial());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  getWeatherLocation(String locationName) async {
    emit(LoadingWeatherLocationState());
    final failureOrWeatherLocation =
        await getWeatherByLocationName(locationName);
    emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }

  getCurrentLocation() async {
    final failureOrWeatherLocation = await getCurrentWeatherLocation();
    emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }

  getFavoriteLocations() async {
    final failureOrWeatherLocation = await getFavoriteLocation();
    _mapFailureOrFavoriteWeatherLocationsToState(failureOrWeatherLocation);
  }

  refreshWeatherLocation(String locationName) async {
    emit(LoadingWeatherLocationState());
    await getFavoriteLocations();
    final failureOrWeatherLocation =
        await getWeatherByLocationName(locationName);
    emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }

  addFavoriteWeatherLocation(String weatherLocationName) async {
    //emit(LoadingWeatherLocationState());
    print(weatherLocationName);
    //final failureOrDoneMessage =
    await addFavoriteLocation(weatherLocationName);
    //getOtherWeatherLocations();

    // emit(
    //   _eitherDoneMessageOrErrorState(
    //       failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
    // );
  }

  addAnotherLocation(String locationName) async {
    await addToOtherLocations(locationName);
  }

  getOtherWeatherLocations() async {
    final failureOrWeatherLocation = await getOtherLocations();
    _mapFailureOrOtherWeatherLocationsToState(failureOrWeatherLocation);
  }

  WeatherLocationState _mapFailureOrWeatherLocationToState(
      Either<Failure, Weather> either) {
    return either.fold(
      (failure) =>
          ErrorWeatherLocationState(message: _mapFailureToMessage(failure)),
      (weatherLocations) {
        currentLocation = weatherLocations;
        return LoadedWeatherLocationState(
          weatherLocation: weatherLocations,
        );
      }
    );
  }

  _mapFailureOrFavoriteWeatherLocationsToState(
      Either<Failure, List<Weather>> either) {
    return either.fold(
        (failure) =>
            ErrorWeatherLocationState(message: _mapFailureToMessage(failure)),
        (favoriteWeatherLocations) {
      favoriteLocations = favoriteWeatherLocations;
      LoadedFavouriteWeatherLocationState(favoriteWeatherLocations: favoriteWeatherLocations);
    });
  }

  _mapFailureOrOtherWeatherLocationsToState(
      Either<Failure, List<Weather>> either) {
    return either.fold(
            (failure) =>
            ErrorWeatherLocationState(message: _mapFailureToMessage(failure)),
            (otherLocations) {
              otherWeatherLocations = otherLocations;
          LoadedOtherWeatherLocationState(otherLocations: otherLocations);
        });
  }

  WeatherLocationState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddFavoriteLocationState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddFavoriteLocationState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
