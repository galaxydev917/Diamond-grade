// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticItem _$StaticFromJson(Map<String, dynamic> json) {
  return StaticItem(
    min: json['min'] as String,
    max: json['max'] as String,
    result: json['result'] as String,
    grade: json['grade'] as String,
  );
}

Map<String, dynamic> _$StaticToJson(StaticItem instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'result': instance.result,
      'grade': instance.grade,
};
