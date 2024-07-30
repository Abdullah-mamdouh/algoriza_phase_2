
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';

import '../../../../core/util/widget/loader.dart';
import '../bloc/cubit.dart';
import '../pages/location_weather_details.dart';


class ProfileDrawer extends StatefulWidget {
  ProfileDrawer({Key? key, required this.locationWeather}) : super(key: key);
  Weather locationWeather;

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  ConstantColor constantColor = ConstantColor();
  List<Weather> favoriteLocations = [];

  @override
  void initState() {
    // AppBloc.get(context).getFavoriteLocations();
    AppBloc.get(context).getOtherWeatherLocations();
    favoriteLocations = AppBloc.favoriteLocations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AppBloc.get(context).getFavoriteLocations();
    // AppBloc.get(context).getOtherWeatherLocations();
    debugPrint(AppBloc.otherWeatherLocations.length.toString());
    //favoriteLocations = AppBloc.get(context).getFavoriteLocation as List<Weather>;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Drawer(
        backgroundColor: constantColor.drawerBackground,

        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            //color: Colors.red,
            child: Column(
              children: [
                ListTile(
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.settingsOutline,
                        color: Colors.white,
                      )),
                ),
                weatherDetailsButton(),
                ListTile(
                  leading: Icon(
                    Icons.star_purple500_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    'Favourite location',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EvaIcons.alertCircleOutline,
                        color: Colors.white,
                      )),
                ),
               locationsContainer(AppBloc.favoriteLocations),
                _divider(),
                ListTile(
                  leading: Icon(
                    Icons.add_location,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    'other locations',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
               locationsContainer(AppBloc.otherWeatherLocations),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    LoaderX.show(context);
                    await AppBloc.get(context).getCurrentLocation();
                    //debugPrint(AppBloc.currentLocation!.location.toString());
                    LoaderX.hide();
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationWeatherDetails(
                            locationWeather: AppBloc.currentLocation!),
                      ),
                    );*/
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        color: constantColor.drawerButton),
                    child: Text(
                      'Manage Location',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
               const SizedBox(height: 12,),
               _divider(),

                ListTile(
                  leading: Icon(
                    EvaIcons.alertCircleOutline,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    'Report wrong location',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    EvaIcons.headphonesOutline,
                    color: Colors.white,
                    size: 25,
                  ),
                  title: Text(
                    'contact us',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _divider(){
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            height: 1.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget locationsContainer(List<Weather> locations) {
    return Container(
      //color: Colors.green,
      height: 100 + (MediaQuery.of(context).size.height *((locations.length)/100))%100,
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          //debugPrint(AppBloc.favoriteLocations[index].location!.name.toString());
          var weatherLocation = locations[index];
          return ListTile(
            onTap: () {
              Navigator.pop(context);
              debugPrint(locations[index].location.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LocationWeatherDetails(locationWeather: locations[index]),
                ),
              );
            },
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.white,size: 15,
                      ),
                      const SizedBox(width: 3,),
                      Text(
                        "${weatherLocation.location!.name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 18,
                            child: Image.network(
                                'http:${weatherLocation.current!.condition!.icon}'),
                            backgroundColor: Colors.transparent),
                        Text(
                          '${weatherLocation.current!.tempC!.toInt()}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget weatherDetailsButton(){
    return GestureDetector(
      onTap: () {
        debugPrint(AppBloc.currentLocation!.location.toString());
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationWeatherDetails(
              locationWeather: widget.locationWeather,),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18),
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: constantColor.drawerButton),
        child: Text(
          'Weather Details',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
