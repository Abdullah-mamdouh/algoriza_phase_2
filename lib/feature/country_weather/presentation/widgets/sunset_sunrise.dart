
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
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if(state is ChangedCardColorState){
            _color = state.cardColor;
          }
          return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('Sunrise', style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 5,),
              Text('${widget.astroDay.sunrise}', style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 15,),
              Image.asset('assets/image/sunrise.png'),
            ],
          ),
          Column(
            children: [
              Text('Sunset', style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 5,),
              Text('${widget.astroDay.sunset}', style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 15,),
              Image.asset('assets/image/sunset.png'),
            ],
          ),
        ],
      ),
    );
  });
  }
}
