

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/country_weather/data/models/weather.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failuers.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/weather_entity.dart';

abstract class WeatherDataSource{

  Future<WeatherModel> getWeatherByLocationName(String locationName);
  Future<Unit> addFavoriteLocation(String locationName);
  Future<List<WeatherModel>> getFavoriteLocation();

}

const BASE_URL = "http://api.weatherapi.com/v1/forecast.json?key=${API_Key}";
const API_Key = '3cd5099903384350ac4201921223008';
const Favorite_Location = 'favoriteLocations';

class WeatherDataSourceImpl implements WeatherDataSource{
  final http.Client client;
  final SharedPreferences sharedPreferences;
  List<String>? favoriteLocations ;

  WeatherDataSourceImpl({required this.client, required this.sharedPreferences});

  @override
  Future<Unit> addFavoriteLocation(String locationName) async {
    sharedPreferences.setStringList(Favorite_Location, ['giza']);
    favoriteLocations = sharedPreferences.getStringList(Favorite_Location);
    debugPrint(favoriteLocations!.toList().toString());
    favoriteLocations!.add(locationName);
    sharedPreferences.setStringList(Favorite_Location, favoriteLocations!);
    return Future.value(unit);
  }

  @override
  Future<WeatherModel> getWeatherByLocationName(String locationName) async{
    final response = await client.get(
      Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=3cd5099903384350ac4201921223008&q=beni suef&days=7"
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
    List<String>? locations = await sharedPreferences.getStringList(Favorite_Location);
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

}