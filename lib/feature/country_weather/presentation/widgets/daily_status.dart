
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/theme_bloc/cubit.dart';
import '../bloc/theme_bloc/state.dart';

class DailyStatus extends StatefulWidget {
  const DailyStatus({Key? key}) : super(key: key);

  @override
  State<DailyStatus> createState() => _DailyStatusState();
}

class _DailyStatusState extends State<DailyStatus> {

  Color? _color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if(state is ChangedCardColorState){
           _color = state.cardColor;
          }
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Lottie.asset(
                        "assets/image/sun_status.json", width: 60, height: 60),
                    SizedBox(height: 5,),
                    Text('UV index', style: TextStyle(fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),),
                    Text('${getExposureCategory(7)}', style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),),
                  ],
                ),
                Container(color: Colors.red, height: 90, width: 2,),
                Column(
                  children: [
                    Lottie.asset(
                        "assets/image/wind.json", width: 60, height: 60),
                    SizedBox(height: 5,),
                    Text('Wind', style: TextStyle(fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),),
                    SizedBox(height: 3,),
                    Text('39 km/h', style: TextStyle(fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),),
                  ],
                ),
                Column(
                  children: [
                    Lottie.asset(
                        "assets/image/humidly.json", width: 60, height: 60),
                    SizedBox(height: 5,),
                    Text('Humidity', style: TextStyle(fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),),
                    SizedBox(height: 3,),
                    Text('31%', style: TextStyle(fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),),
                  ],
                )
              ],
            ),
          );
        }
    );

  }

  String getExposureCategory(double index){
   if(index <3){
     return 'Low';
   }else  if(index < 6){
     return 'Moderate';
   }else  if(index < 8){
     return 'High';
   }else  if(index < 11){
     return 'Very High';
   }else{
     return 'Extreme';
   }

  }
}
