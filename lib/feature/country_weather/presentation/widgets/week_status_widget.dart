
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';
import 'package:weather_app/feature/country_weather/domain/entities/forecast_of_day_entity.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';

import '../../../../core/functions/get_dayName_by_date.dart';
import '../bloc/theme_bloc/cubit.dart';
import '../bloc/theme_bloc/state.dart';

class WeekStatus extends StatefulWidget {
  WeekStatus({Key? key, required this.weatherDay}) : super(key: key);

  Weather weatherDay;
  @override
  State<WeekStatus> createState() => _WeekStatusState();
}

class _WeekStatusState extends State<WeekStatus> {

  ConstantColor constantColor = ConstantColor();
  Color? _color;
  @override
  Widget build(BuildContext context) {
    final days = widget.weatherDay.forecast!.forecastday;
    final currentWeather = widget.weatherDay.current;
    _color = ThemeBloc.cardColor;
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _color,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: days!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) => Container(
          //width: double.infinity,height: 50,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index == 0 ? 'Today ' : '${getDayName('${days[index].date}')}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w600),
              ),
              //SizedBox(width: 25,),
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset('assets/image/water.png'),
                        Text('${currentWeather!.humidity}',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12)),
                        Text('%',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Image.network(
                            'http://cdn.weatherapi.com/weather/64x64/day/113.png'),
                        //SizedBox(width: 5,),
                        Image.network(
                            'http://cdn.weatherapi.com/weather/64x64/night/113.png'),
                      ],
                    ),
                  ),

                  //SizedBox(width: 15,),
                  Text(
                    '${days[index].day!.maxtempC!.toInt()}° ${days[index].day!.mintempC!.toInt()}°',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
