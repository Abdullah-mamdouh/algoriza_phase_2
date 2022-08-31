

import 'package:equatable/equatable.dart';

class Astro extends Equatable {
  String? sunrise;
  String? sunset;
  // String? moonrise;
  // String? moonset;
  // String? moonPhase;
  // String? moonIllumination;

  Astro(
      {this.sunrise,
        this.sunset,
        // this.moonrise,
        // this.moonset,
        // this.moonPhase,
        // this.moonIllumination
      });

  @override
  // TODO: implement props
  List<Object?> get props => [sunrise, sunset];

}