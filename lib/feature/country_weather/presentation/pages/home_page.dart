import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/cubit.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/states.dart';
import 'package:weather_app/feature/country_weather/presentation/pages/location_weather_details.dart';

import '../../../../core/util/message/message_display_widget.dart';
import '../widgets/loading_widget.dart';

const double _searchBarHeight = 54;
const double _searchBarVerticalMargin = 12;
const double _appBarCollapsedHeight =
    _searchBarHeight + _searchBarVerticalMargin * 2; // 78
const double _appBarExpandedHeight = 100 + _searchBarHeight; // 154

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // 0.0 -> Expanded
  double currentExtent = 0.0;

  double get minExtent => 0.0;
  double get maxExtent => _scrollController.position.maxScrollExtent;

  double get deltaExtent => maxExtent - minExtent;

  Curve get curve => Curves.easeOutCubic;
  // Curve get curve => Curves.easeOutQuart;

  // Curve get curve => Curves.easeOutQuint;
  // Curve get curve => Curves.easeOutExpo;
  // Curve get curve => Curves.easeOutCirc;
  // Curve get curve => Curves.fastLinearToSlowEaseIn;

  // Curve get curve => const Cubic(0.08, 0.79, 0, 0.81);

  double actionSpacing = 24;
  double iconStrokeWidth = 1.8;
  double titlePaddingHorizontal = 16;
  double titlePaddingTop = 74;

  final Tween<double> actionSpacingTween = Tween(begin: 24, end: 0);
  final Tween<double> iconStrokeWidthTween = Tween(begin: 1.8, end: 1.2);
  final Tween<double> titlePaddingHorizontalTween = Tween(begin: 16, end: 48);
  final Tween<double> titlePaddingTopTween = Tween(begin: 74, end: 12);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, WeatherLocationState>(
        builder: (context, state) {
          if (state is LoadingWeatherLocationState) {
            return LoadingWidget();
          }
          else if (state is LoadedWeatherLocationState) {
            print(state.weatherLocation.forecast!.forecastday!.length);
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: LocationWeatherDetails(locationWeather: state.weatherLocation));
          }
          else if (state is ErrorWeatherLocationState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
      /*NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          leading: Row(
            children: [
              SizedBox(width: actionSpacing),
              IconButton(
                onPressed: () {},
                splashRadius: 24,
                icon:  Icon(Icons.category),//CategoryIconPainter.getCustomPaint(iconStrokeWidth),
              ),
            ],
          ),
          leadingWidth: 74,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              splashRadius: 24,
              icon: Icon(Icons.search_sharp),//NotificationIconPainter.getCustomPaint(iconStrokeWidth),
            ),
            SizedBox(width: actionSpacing),
          ],
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
              centerTitle: true,
              title: Column(
                children: [
                  SizedBox(
                    height: _searchBarHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 20),
                          Icon(Icons.search_sharp),//SearchIconPainter.customPaint,
                          SizedBox(width: 16),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0x90000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
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
      body: widget.body,
    );*/
  }
  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<AppBloc>(context).refreshWeatherLocation('cairo');
  }
  _scrollListener() {
    setState(() {
      currentExtent = _scrollController.offset;

      actionSpacing = _remapCurrentExtent(actionSpacingTween);
      iconStrokeWidth = _remapCurrentExtent(iconStrokeWidthTween);
      titlePaddingHorizontal = _remapCurrentExtent(titlePaddingHorizontalTween);
      titlePaddingTop = _remapCurrentExtent(titlePaddingTopTween);
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

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}