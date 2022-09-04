
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';

import '../../domain/entities/astro_entity.dart';
import '../bloc/theme_bloc/cubit.dart';
import '../bloc/theme_bloc/state.dart';

class SunsetAndSunrise extends StatefulWidget {
  SunsetAndSunrise({Key? key, required this.astroDay}) : super(key: key);
  Astro astroDay;
  @override
  State<SunsetAndSunrise> createState() => _SunsetAndSunriseState();
}

class _SunsetAndSunriseState extends State<SunsetAndSunrise> {

  ConstantColor constantColor = ConstantColor();
  Color? _color;
  @override
  Widget build(BuildContext context) {
    _color = ThemeBloc.cardColor;
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          sunStatus('Sunrise', 'sunrise', '${widget.astroDay.sunrise}'),
          sunStatus('Sunset', 'sunset', '${widget.astroDay.sunset}'),

        ],
      ),
    );
  }
  sunStatus(String status, String imageName, String astroDaySun){
    return Column(
      children: [
        Text(
          '${status}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${astroDaySun}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Image.asset('assets/image/${imageName}.png'),
      ],
    );
  }
}