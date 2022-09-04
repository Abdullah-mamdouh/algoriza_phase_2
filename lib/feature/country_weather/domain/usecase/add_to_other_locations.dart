


import 'package:dartz/dartz.dart';

import '../../../../core/error/failuers.dart';
import '../repositories/weather_repository.dart';

class AddToOtherLocations {
  final WeatherRepository repository;

  AddToOtherLocations(this.repository);

  Future<Either<Failure, Unit>> call(String locationName) async {
    return await repository.addToOtherLocation(locationName);
  }

}