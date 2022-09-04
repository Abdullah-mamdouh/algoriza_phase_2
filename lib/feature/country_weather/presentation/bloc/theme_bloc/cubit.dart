

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constant_colors/constant_colors.dart';
import 'package:weather_app/feature/country_weather/presentation/bloc/theme_bloc/state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  //ConstantColor constantColor = ConstantColor();
  static Color backgroundColor = ConstantColor().fristBackgroundColor;
  static Color cardColor = ConstantColor().fristcardColor;

  ThemeBloc() : super(InitialColorState());

  static ThemeBloc get(context) => BlocProvider.of<ThemeBloc>(context);

  /// change background color of location weather details
  changeBackgroundColor(Color _color){

    backgroundColor = _color;
    emit(ChangedBackgroundColorState(backgroundColor: backgroundColor));
  }

  ///change color of card at location weather details
  changeCardColor(Color _color){

    cardColor = _color;
    emit(ChangedCardColorState(cardColor: cardColor));

  }
}