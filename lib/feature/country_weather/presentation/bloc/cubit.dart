

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/add_favorite_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_favourite_location.dart';
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
  static List<Weather> favoriteLocations = [];
  AppBloc({
    required this.getWeatherByLocationName,
    required this.addFavoriteLocation,
    required this.getFavoriteLocation,

  }) : super(WeatherLocationInitial());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);


  getWeatherLocation(String locationName) async{
    emit(LoadingWeatherLocationState());
    final failureOrWeatherLocation = await getWeatherByLocationName(locationName);
    emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }
  getFavoriteLocations()async{
    final failureOrWeatherLocation = await getFavoriteLocation();
    // emit(_mapFailureOrFavoriteWeatherLocationsToState(failureOrWeatherLocation));
  }

  refreshWeatherLocation(String locationName) async{
    emit(LoadingWeatherLocationState());
    final failureOrWeatherLocation = await getWeatherByLocationName(locationName);
    emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }

  addFavoriteWeatherLocation(String weatherLocationName) async{
    //emit(LoadingWeatherLocationState());

    final failureOrDoneMessage = await addFavoriteLocation(weatherLocationName);

    // emit(
    //   _eitherDoneMessageOrErrorState(
    //       failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
    // );
  }

  WeatherLocationState _mapFailureOrWeatherLocationToState(Either<Failure,Weather> either) {

    return either.fold(
          (failure) => ErrorWeatherLocationState(
              message: _mapFailureToMessage(failure)),
          (weatherLocations) => LoadedWeatherLocationState(
        weatherLocation: weatherLocations,
      ),
    );
  }

  WeatherLocationState _mapFailureOrFavoriteWeatherLocationsToState(Either<Failure,List<Weather>> either) {

    return either.fold(
          (failure) => ErrorWeatherLocationState(
          message: _mapFailureToMessage(failure)),
          (favoriteWeatherLocations) {
          favoriteLocations = favoriteWeatherLocations;
    }
      //         LoadedFavouriteWeatherLocationState(
      //       favoriteWeatherLocations: favoriteWeatherLocations,
      // ),
    );
  }

  WeatherLocationState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
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
