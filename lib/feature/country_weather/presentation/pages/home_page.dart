import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/cubit.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/states.dart';
import 'package:weather_app/feature/country_weather/presentation/pages/location_weather_details.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/drawer_profile.dart';

import '../../../../core/util/message/message_display_widget.dart';
import '../widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
HomePage({Key? key, required this.locationWeather})
    : super(key: key);
Weather locationWeather;

@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String weather = 'lightcloud';
  String errorMessage = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // AppBloc.get(context).getOtherWeatherLocations();
    // AppBloc.get(context).getFavoriteLocations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // AppBloc.get(context).getOtherWeatherLocations();
    // AppBloc.get(context).getFavoriteLocations();

    final locationInfo = widget.locationWeather.location;
    final forecastInfo = widget.locationWeather.forecast;
    final currentWeatherInfo = widget.locationWeather.current;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/$weather.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            key: _scaffoldKey,
            drawer: ProfileDrawer(locationWeather: widget.locationWeather,),
            // DrawerProile(locationWeather: widget.locationWeather,),
            appBar: AppBar(
              leading: IconButton(
                onPressed:(){
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu,size: 35),),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[

                    Center(
                      child: Text(
                        forecastInfo!.forecastday![0].day!.avgtempC!.toInt().toString()+ ' °C',
                        style: TextStyle(
                            color: Colors.white, fontSize: 60.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        locationInfo!.name!,
                        style: TextStyle(
                            color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: TextField(
                        onSubmitted: (String input) async{
                          AppBloc.get(context).addAnotherLocation(input);
                          await searchByCountryName(input);
                        },
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                          hintText: 'Search another location...',
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: 18.0),
                          prefixIcon:
                          Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 32.0, left: 32.0),
                      child: Text(errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                            //Platform.isAndroid ? 15.0 : 20.0
                          )),
                    )
                  ],
                ),
              ],
            ),
          )),

    );
  }
  searchByCountryName(String locationName){
    AppBloc.get(context).getWeatherLocation(locationName);
    // AppBloc.get(context).getOtherWeatherLocations();
    AppBloc.get(context).state;

    // return  BlocBuilder<AppBloc, WeatherLocationState>(
    //     builder: (context, state) {
    //
    //       if (state is LoadingWeatherLocationState) {
    //         return LoadingWidget();
    //       }
    //       else if (state is LoadedWeatherLocationState) {
    //         print('gggggggggg');
    //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //             LocationWeatherDetails(locationWeather: state.weatherLocation),));
    //       }
    //       else if (state is ErrorWeatherLocationState) {
    //         return MessageDisplayWidget(message: state.message);
    //       }
    //       return LoadingWidget();
    //     });
  }
}
