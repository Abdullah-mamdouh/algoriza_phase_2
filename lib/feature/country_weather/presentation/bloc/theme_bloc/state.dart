


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class InitialColorState extends ThemeState {}

class ChangedBackgroundColorState extends ThemeState {

  Color backgroundColor;
  ChangedBackgroundColorState({required this.backgroundColor});

  @override
  List<Object> get props => [backgroundColor];
}

class ChangedCardColorState extends ThemeState {

  Color cardColor;
  ChangedCardColorState({required this.cardColor});

  @override
  List<Object> get props => [cardColor];
}