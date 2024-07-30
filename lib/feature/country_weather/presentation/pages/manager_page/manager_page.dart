
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/message/message_display_widget.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../widgets/loading_widget.dart';
import '../home_page.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({Key? key}) : super(key: key);

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {

  @override
  void initState() {
    AppBloc.get(context).getOtherWeatherLocations();
    AppBloc.get(context).getFavoriteLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AppBloc.get(context).getOtherWeatherLocations();
    // AppBloc.get(context).getFavoriteLocations();
    //AppBloc.get(context).getWeatherLocation(AppBloc.locationName!);
    return Scaffold(
      body: BlocBuilder<AppBloc, WeatherLocationState>(
        builder: (context, state) {
          if (state is LoadingWeatherLocationState) {
            return const LoadingWidget();
          }
          else if (state is LoadedWeatherLocationState) {
            //print(state.weatherLocation.forecast!.forecastday!.length);
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: HomePage(locationWeather: state.weatherLocation),
              //LocationWeatherDetails(locationWeather: state.weatherLocation)
            );
          }
          else if (state is ErrorWeatherLocationState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<AppBloc>(context).refreshWeatherLocation('cairo');
  }

}

