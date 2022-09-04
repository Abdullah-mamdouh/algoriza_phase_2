import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/country_weather/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/add_favorite_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/add_to_other_locations.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_current_weather_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_favourite_location.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_other_locations.dart';
import 'package:weather_app/feature/country_weather/domain/usecase/get_weather_by_location_name.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/cubit.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/theme_bloc/cubit.dart';

import 'core/network/network_info.dart';
import 'feature/country_weather/data/repositories/weather_repository_impl.dart';
import 'feature/country_weather/domain/repositories/weather_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// bloc
  sl.registerFactory(
    () => AppBloc(
        getWeatherByLocationName: sl(),
        getCurrentWeatherLocation: sl(),
        addFavoriteLocation: sl(),
        getFavoriteLocation: sl(),
        addToOtherLocations: sl(),
        getOtherLocations: sl()),
  );
  sl.registerFactory(
    () => ThemeBloc(),
  );

  /// Usecase
  sl.registerLazySingleton(() => GetWeatherByLocationName(sl()));
  sl.registerLazySingleton(() => GetCurrentWeatherLocation(sl()));
  sl.registerLazySingleton(() => AddFavoriteLocation(sl()));
  sl.registerLazySingleton(() => GetFavoriteLocation(sl()));
  sl.registerLazySingleton(() => AddToOtherLocations(sl()));
  sl.registerLazySingleton(() => GetOtherLocations(sl()));

  /// Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// data source
  sl.registerLazySingleton<WeatherDataSource>(
      () => WeatherDataSourceImpl(client: sl(), sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
