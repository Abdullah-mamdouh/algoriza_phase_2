import '../../domain/entities/condition_entity.dart';

class ConditionModel extends Condition {
  ConditionModel(
      {required String? text, required String? icon, required int? code})
      : super(icon: icon, text: text, code: code);

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
        text: json['text'], icon: json['icon'], code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}
