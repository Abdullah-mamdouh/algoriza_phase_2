


import 'package:dartz/dartz.dart';

import '../../../../core/error/failuers.dart';
import '../repositories/weather_repository.dart';

class AddFavoriteLocation {
  final WeatherRepository repository;

  AddFavoriteLocation(this.repository);

  Future<Either<Failure, Unit>> call(String locationName) async {
    return await repository.addfavoriteLocation(locationName);
  }

}