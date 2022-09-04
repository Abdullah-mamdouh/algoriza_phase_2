
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';
import 'package:weather_app/feature/country_weather/domain/entities/hour_entity.dart';

import '../bloc/theme_bloc/cubit.dart';
import '../bloc/theme_bloc/state.dart';

class HourStatus extends StatefulWidget {
  HourStatus({Key? key, required this.hours}) : super(key: key);
  List<Hour> hours;

  @override
  State<HourStatus> createState() => _HourStatusState();
}

class _HourStatusState extends State<HourStatus> {
  ConstantColor constantColor = ConstantColor();
  Color? _color;
  @override
  Widget build(BuildContext context) {
    final hours = widget.hours;
    _color = ThemeBloc.cardColor;
    return Container(
      //padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height*0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: _color,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: hours.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${getHourByDateTime('${hours[index].time}')}',
                  style: TextStyle(color: Colors.white, fontSize: 13),),
                SizedBox(height: 5,),
                Image.network('http:${hours[index].condition!.icon}',),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Image.asset('assets/image/water.png'),
                    Text('${hours[index].humidity!.toInt()}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12)),
                    Text('%', style: TextStyle(
                        color: Colors.white, fontSize: 12)),
                  ],
                )
              ],
            ),
      ),
    );
  }
  getHourByDateTime(String dateTime){
    String time = dateTime.split(' ')[1];
    String hour = time.split(':')[0];
    int hourNumber = int.parse(hour);
    if(hourNumber == 00){
      return '12 am';
    }
    if(hourNumber >= 13){
      return "${hourNumber%12} pm";
    }
    else {
      return '$hourNumber am';
    }
  }
}
