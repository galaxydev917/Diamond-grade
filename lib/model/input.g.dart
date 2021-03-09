// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Input _$InputFromJson(Map<String, dynamic> json) {
  return Input(
    weight: (json['weight'] as num).toDouble(),
    colour: (json['colour'] as String),
    clarity: (json['clarity'] as String),
    starface: (json['starface'] as num).toDouble(),
    culet: (json['culet'] as String),
    depthPct: (json['depth_pct'] as num).toDouble(),
    crownHeight: (json['crown_height'] as num).toDouble(),
    pavilionDepth: (json['pavilion_depth'] as num).toDouble(),
    pavilionAngle: (json['pavilion_angle'] as num).toDouble(),
    girdle: (json['girdle'] as num).toDouble(),
    crownAngle: (json['crown_angle'] as num).toDouble(),
    lowerHalf: (json['lower_half'] as num).toDouble(),
    tablePct: (json['table_pct'] as num).toDouble(),
  );
}

Map<String, dynamic> _$InputToJson(Input instance) => <String, dynamic>{
      'weight': instance.weight,
      'colour': instance.colour,
      'clarity': instance.clarity,
      'starface': instance.starface,
      'culet': instance.culet,
      'depth_pct': instance.depthPct,
      'crown_height': instance.crownHeight,
      'pavilion_depth': instance.pavilionDepth,
      'pavilion_angle': instance.pavilionAngle,
      'girdle': instance.girdle,
      'crown_angle': instance.crownAngle,
      'lower_half': instance.lowerHalf,
      'table_pct': instance.tablePct,
    };
