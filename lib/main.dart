import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/country_weather/presentation/pages/location_weather_details.dart';
import 'package:weather_app/feature/country_weather/presentation/pages/manager_page/manager_page.dart';

import 'dependency_injuction.dart' as di;
import 'feature/country_weather/data/data_source/weather_remote_data_source.dart';
import 'package:http/http.dart' as http;

import 'feature/country_weather/presentation/bloc/cubit.dart';
import 'feature/country_weather/presentation/bloc/theme_bloc/cubit.dart';
import 'feature/country_weather/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await WeatherDataSourceImpl(
  //   sharedPreferences: await SharedPreferences.getInstance(),
  //   client: http.Client(),
  // ).getWeatherByLocationName('cairo');
  // print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
 // WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(create: (_) => di.sl<AppBloc>()..getWeatherLocation('cairo')),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          home: ManagerPage()
          /*SliverScaffold(
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemCount: 5,
          itemBuilder: (_, __) => const SizedBox(
            height: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),*/
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
