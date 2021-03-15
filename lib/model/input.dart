import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sorts_app/model/report.dart';
import 'package:sorts_app/service/Database.dart';

part 'input.g.dart';

@JsonSerializable(nullable: false)
class Input {
  @JsonKey(name: 'weight')
  double weight;
  @JsonKey(name: 'colour')
  String colour;
  @JsonKey(name: 'clarity')
  String clarity;
  @JsonKey(name: 'starface')
  double starface;
  @JsonKey(name: 'culet')
  String culet;
  @JsonKey(name: 'depth_pct')
  double depthPct;
  @JsonKey(name: 'crown_height')
  double crownHeight;
  @JsonKey(name: 'pavilion_depth')
  double pavilionDepth;
  @JsonKey(name: 'pavilion_angle')
  double pavilionAngle;
  @JsonKey(name: 'girdle')
  double girdle;
  @JsonKey(name: 'crown_angle')
  double crownAngle;
  @JsonKey(name: 'lower_half')
  double lowerHalf;
  @JsonKey(name: 'table_pct')
  double tablePct;

  Input({
    @required this.weight,
    @required this.colour,
    @required this.clarity,
    @required this.starface,
    @required this.culet,
    @required this.depthPct,
    @required this.crownHeight,
    @required this.pavilionDepth,
    @required this.pavilionAngle,
    @required this.girdle,
    @required this.crownAngle,
    @required this.lowerHalf,
    @required this.tablePct,
  });

  Input.init();

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);
  Map<String, dynamic> toJson() => _$InputToJson(this);

  Future<Report> submit(reportData) async {
    // print(this.toJson());
    // Map<String, dynamic> reportData = this.toJson();
    // reportData['grade'] = grade;
    await DBProvider.db.addReport(reportData);

    
    return Report.fromJson(reportData);
  }
}
