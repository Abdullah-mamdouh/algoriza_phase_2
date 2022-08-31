import 'package:flutter/cupertino.dart';

import '../../domain/entities/astro_entity.dart';

class AstroModel extends Astro {
  AstroModel({
    required String? sunrise,
    required String? sunset,
    // required String? moonrise,
    // required String? moonset,
    // required String? moonPhase,
    // required String? moonIllumination,
  }) : super(
            sunrise: sunrise,
            sunset: sunset,
            // moonset: moonset,
            // moonrise: moonrise,
            // moonIllumination: moonIllumination,
            // moonPhase: moonPhase
  );

  factory AstroModel.fromJson(Map<String, dynamic> json) {
    //debugPrint("----> AstroModel <-----" +json.toString());
    return AstroModel(
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        // moonrise: json['moonrise'],
        // moonset: json['moonset'],
        // moonPhase: json['moon_phase'],
        // moonIllumination: json['moon_illumination']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
      // 'moonrise': moonrise,
      // 'moonset': moonset,
      // 'moon_phase': moonPhase,
      // 'moon_illumination': moonIllumination,
    };
  }
}
