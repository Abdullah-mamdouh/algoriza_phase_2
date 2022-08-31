

import 'package:equatable/equatable.dart';

class Condition extends Equatable {

  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  @override
  // TODO: implement props
  List<Object?> get props => [text, icon, code];

}