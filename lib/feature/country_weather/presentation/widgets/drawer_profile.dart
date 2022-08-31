
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/country_weather/domain/entities/weather_entity.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../pages/location_weather_details.dart';
import 'loading_widget.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  List<Weather> favoriteLocations = [];
  @override
  void initState() {
    AppBloc.get(context).getFavoriteLocations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //favoriteLocations = AppBloc.get(context).getFavoriteLocation as List<Weather>;
    return BlocBuilder<AppBloc, WeatherLocationState>(
        builder: (context, state) {
      if (state is LoadedFavouriteWeatherLocationState) {
        debugPrint(state.favoriteWeatherLocations.toList().toString());
        favoriteLocations = state.favoriteWeatherLocations;
        return Drawer(
          //backgroundColor: constantColors.blackLight2,
          child: ListView.builder(
            itemCount: favoriteLocations.length,
            itemBuilder: (context, index) {
              return Container(color: Colors.red, height: 20,);
            },
            // Important: Remove any padding from the ListView.
            // padding: EdgeInsets.zero,
            // children: <Widget>[
            //   // UserAccountsDrawerHeader(
            //   //   decoration: BoxDecoration(color: constantColors.fristcardColor),
            //   //   accountName: Text(
            //   //     //'${user!.name}'
            //   //       '${userInfo.displayName}'
            //   //   ),
            //   //   accountEmail: Text(
            //   //     //'${user!.email}'
            //   //       "${userInfo.email}"
            //   //   ),
            //   //   currentAccountPicture: GestureDetector(
            //   //       child: CircleAvatar(
            //   //           backgroundImage: AssetImage("assets/image/signin_top.png")
            //   //         //FileImage(user!.photo!),
            //   //
            //   //       ),
            //   //       onTap: () {
            //   //         /*Provider.of<ProductProvider>(context, listen: false)
            //   //                  .saveImage(pref.getString('image').toString());
            //   //              Provider.of<ProductProvider>(context, listen: false)
            //   //                  .saveName_email(pref.getString('name').toString(),
            //   //                  pref.getString('email').toString());
            //   //              Navigator.push(
            //   //                context,
            //   //                MaterialPageRoute(
            //   //                  builder: (context) => Profile(),
            //   //                ),
            //   //              );*/
            //   //       }),
            //   // ),
            //   //Divider(color: constantColors.lightColor,height: 15,),
            //
            //   // ListTile(
            //   //   leading: SwitchButton(),
            //   //
            //   // ),
            //   ListTile(
            //     leading: Icon(Icons.account_circle_outlined,),
            //     title: Text("Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            //     onTap: () async {
            //       Navigator.pop(context);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => UserInfoWidget(),
            //         ),
            //       );
            //     },
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/image/weather_details.png',height: 30,width: 30,fit: BoxFit.cover,),
            //     title: Text("Weather Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            //     onTap: () {
            //       Navigator.pop(context);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => LocationWeatherDetails(locationWeather: widget.locationWeather),
            //         ),
            //       );
            //     },
            //   ),
            // ],
          ),
        );
      }
      else return LoadingWidget();
    });
  }
}
