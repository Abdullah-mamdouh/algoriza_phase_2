import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';
import 'package:weather_app/feature/country_weather/data/models/weather.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/theme_bloc/cubit.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/daily_status.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/drawer_profile.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/hour_status_widget.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/sunset_sunrise.dart';
import 'package:weather_app/feature/country_weather/presentation/widgets/week_status_widget.dart';

import '../../domain/entities/weather_entity.dart';
import '../bloc/cubit.dart';

const double _appBarCollapsedHeight = 200; // 78
const double _appBarExpandedHeight = 290; // 154

class LocationWeatherDetails extends StatefulWidget {
  LocationWeatherDetails({Key? key, required this.locationWeather})
      : super(key: key);
  Weather locationWeather;
  @override
  State<LocationWeatherDetails> createState() => _LocationWeatherDetailsState();
}

class _LocationWeatherDetailsState extends State<LocationWeatherDetails> {
  final ScrollController _scrollController = ScrollController();

  double currentExtent = 0.0;

  double get minExtent => 0.0;
  double get maxExtent => _scrollController.position.maxScrollExtent;

  double get deltaExtent => maxExtent - minExtent;

  Curve get curve => Curves.easeOutCubic;

  double actionSpacing = 15;
  //double iconStrokeWidth = 1.8;
  double titlePaddingHorizontal = 15;
  double paddingHorizontal = 16;
  double titlePaddingTop = 180;

  final Tween<double> actionSpacingTween = Tween(begin: 15, end: 10);
  final Tween<double> titlePaddingHorizontalTween = Tween(begin: 15, end: 60);
  final Tween<double> titlePaddingTopTween = Tween(begin: 180, end: 60);

  late WeatherModel weatherLocation;
  ConstantColor constantColor = ConstantColor();
  late Color backgroundColor;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    backgroundColor = constantColor.fristBackgroundColor;
    final weather = AppBloc.get(context);
    //weatherLocation =
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final locationInfo = widget.locationWeather.location;
    final forecastInfo = widget.locationWeather.forecast;
    final currentWeatherInfo = widget.locationWeather.current;

    return BlocProvider(
      create: (BuildContext context) => ThemeBloc(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ThemeBloc.backgroundColor,
        //drawer: ProfileDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (_, __) => [
              SliverAppBar(
                backgroundColor:
                    ThemeBloc.backgroundColor,
                leading: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                          //_scaffoldKey.currentState!.openDrawer();
                        }, icon: Icon(Icons.arrow_back_ios_outlined)),
                        SizedBox(
                          width: actionSpacing,
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: actionSpacing,
                        ),
                        Text(
                          '${forecastInfo!.forecastday![0].day!.avgtempC!.toInt()}',
                          style: TextStyle(fontSize: 44, color: Colors.white),
                        ),
                        //SizedBox(width: actionSpacing,),

                        //SizedBox(width: actionSpacing,),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Column(
                    children: [
                      SizedBox(
                        height: 37,
                      ),
                      IconButton(
                          onPressed: () {
                            AppBloc.get(context).addFavoriteWeatherLocation(locationInfo!.name!);
                          },
                          icon: Icon(Icons.star_border_purple500_outlined)),
                      //SizedBox(height: 10,),
                      Row(
                        children: [
                          Lottie.asset("assets/image/sun.json",
                              width: 90, height: 90),
                          SizedBox(
                            width: actionSpacing,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
                leadingWidth: 100,
                toolbarHeight: _appBarCollapsedHeight,
                collapsedHeight: _appBarCollapsedHeight,
                expandedHeight: _appBarExpandedHeight,
                flexibleSpace: FlexibleSpaceBar.createSettings(
                  currentExtent: _appBarCollapsedHeight,
                  minExtent: _appBarCollapsedHeight,
                  maxExtent: _appBarExpandedHeight,
                  toolbarOpacity: 1.0,
                  child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(
                      top: titlePaddingTop,
                      left: titlePaddingHorizontal,
                      right: titlePaddingHorizontal,
                    ),
                    //centerTitle: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${locationInfo!.name.toString()}',
                              style: TextStyle(fontSize: 33),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.add_location_rounded,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              '${forecastInfo.forecastday![0].day!.maxtempC!.toInt()} / ${forecastInfo.forecastday![0].day!.mintempC!.toInt()} Feels like 34',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              '${DateFormat.E().format(DateTime.now())}, ${DateFormat.jm().format(DateTime.now())}',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //backgroundColor: Colors.blue,
                elevation: 8,
                shadowColor: Colors.black45,
                pinned: true,
              ),
            ],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HourStatus(hours: forecastInfo!.forecastday![0].hour!),
                    SizedBox(
                      height: 20,
                    ),
                    WeekStatus(weatherDay: widget.locationWeather),
                    SizedBox(
                      height: 20,
                    ),
                    SunsetAndSunrise(
                        astroDay: forecastInfo.forecastday![0].astro!),
                    SizedBox(
                      height: 20,
                    ),
                    DailyStatus(currentModel: currentWeatherInfo!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _scrollListener() {
    setState(() {
      _onScroll();
      currentExtent = _scrollController.offset;
      actionSpacing = _remapCurrentExtent(actionSpacingTween);
      //iconStrokeWidth = _remapCurrentExtent(iconStrokeWidthTween);
      titlePaddingHorizontal = _remapCurrentExtent(titlePaddingHorizontalTween);
      titlePaddingTop = _remapCurrentExtent(titlePaddingTopTween);
      // paddingHorizontal = _remapCurrentExtent(paddingHorizontalTween);
      // paddingTop = _remapCurrentExtent(paddingTopTween);
    });
  }

  double _remapCurrentExtent(Tween<double> target) {
    final double deltaTarget = target.end! - target.begin!;

    double currentTarget =
        (((currentExtent - minExtent) * deltaTarget) / deltaExtent) +
            target.begin!;

    double t = (currentTarget - target.begin!) / deltaTarget;

    double curveT = curve.transform(t);

    return lerpDouble(target.begin!, target.end!, curveT)!;
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ThemeBloc.get(context).changeBackgroundColor(constantColor.secondBackgroundColor);
      ThemeBloc.get(context).changeCardColor(constantColor.secondcardColor);
    }
    else if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent)
    {

      ThemeBloc.get(context).changeBackgroundColor(constantColor.fristBackgroundColor);
      ThemeBloc.get(context).changeCardColor(constantColor.fristcardColor);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
