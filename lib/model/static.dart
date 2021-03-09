import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staticitem.g.dart';

class StaticItem {

  String min;
  @JsonKey(name: 'min')
  String max;
  @JsonKey(name: 'max')
  String result;
  @JsonKey(name: 'result')
  String grade;
  @JsonKey(name: 'grade')

  StaticItem({
    @required this.min,
    @required this.max,
    @required this.result,
    @required this.grade,
  });

  StaticItem.init();

  factory StaticItem.fromJson(Map<String, dynamic> json) => _$StaticFromJson(json);
  Map<String, dynamic> toJson() => _$StaticToJson(this);




}
