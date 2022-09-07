

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/country_weather/data/models/weather.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failuers.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/weather_entity.dart';

abstract class WeatherDataSource{

  Future<WeatherModel> getWeatherByLocationName(String locationName);
  Future<WeatherModel> getCurrentWeatherLocation();

  Future<Unit> addFavoriteLocation(String locationName);
  Future<List<WeatherModel>> getFavoriteLocation();

  Future<Unit> addAnotherLocation(String locationName);
  Future<List<WeatherModel>> getOtherLocation();
}

const BASE_URL = "http://api.weatherapi.com/v1/forecast.json?key=${API_Key}";
const API_Key = '3cd5099903384350ac4201921223008';
const Favorite_Location = 'favoriteLocations';
const Other_Location = 'OtherLocations';

class WeatherDataSourceImpl implements WeatherDataSource{
  final http.Client client;
  final SharedPreferences sharedPreferences;
  List<String>? favoriteLocations = [] ;
  List<String>? otherLocations = [] ;

  WeatherDataSourceImpl({required this.client, required this.sharedPreferences});

  @override
  Future<Unit> addFavoriteLocation(String locationName) {
    //sharedPreferences.setStringList(Favorite_Location, ['giza']);
    final locations = sharedPreferences.getStringList(Favorite_Location);
    locations != null? favoriteLocations = locations: [];
    //debugPrint(favoriteLocations!.toList().toString());
    favoriteLocations!.add(locationName);
    sharedPreferences.setStringList(Favorite_Location, favoriteLocations!);
    return Future.value(unit);
  }

  @override
  Future<WeatherModel> getWeatherByLocationName(String locationName) async{
    final response = await client.get(
      Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=3cd5099903384350ac4201921223008&q=${locationName}&days=7"
         // BASE_URL + "&q=${locationName}&days=6"
      ),
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      //debugPrint(decodedJson.toString());
      final weatherModel = WeatherModel.fromJson(decodedJson);
     // debugPrint(weatherModel.current!.precipMm.toString());
      return weatherModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<WeatherModel>> getFavoriteLocation() async{
    List<String>? locations = sharedPreferences.getStringList(Favorite_Location);
    List<WeatherModel> favoriteLocations = [];
    if (locations != null) {
      for(int i =0; i<locations.length; i++){

        favoriteLocations.add(await getWeatherByLocationName(locations[i]));
      }
      return favoriteLocations;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<WeatherModel> getCurrentWeatherLocation() async {
    return await getGeoLocationPosition();
  }

  /// get current position
  Future<WeatherModel> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.toJson().toString());
    return await getWeatherByLocationName('${position.latitude},${position.longitude}');
    //return await getAddressFromLatLong(position);
  }

  /// get information of location by latitude and longitude
  Future<WeatherModel> getAddressFromLatLong(Position position)async {

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    //locationName = place.country;
   return await getWeatherByLocationName(place.country!+place.administrativeArea!);

  }

  @override
  Future<Unit> addAnotherLocation(String locationName) {
    final locations = sharedPreferences.getStringList(Other_Location);
    locations != null? otherLocations = locations: [];
    // debugPrint(otherLocations!.toList().toString());
    otherLocations!.add(locationName);
    sharedPreferences.setStringList(Other_Location, otherLocations!);
    debugPrint(otherLocations!.toList().toString());
    return Future.value(unit);
  }

  @override
  Future<List<WeatherModel>> getOtherLocation() async{
    List<String>? locations = sharedPreferences.getStringList(Other_Location);
    List<WeatherModel> otherLocations = [];
    if (locations != null) {
      for(int i =0; i<locations.length; i++){
        otherLocations.add(await getWeatherByLocationName(locations[i]));
    }
    return otherLocations;
    } else {
    throw EmptyCacheException();
    }
  }


}