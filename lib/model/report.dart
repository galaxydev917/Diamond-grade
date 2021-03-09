import 'package:flutter/foundation.dart';

class Report {
  final int id;
  final String grade;
  final String createdAt;
  final String colour;
  final String weight;
  final String clarity;
  final String tablepct;
  final String totaldepth;
  final String crownheight;
  final String crownangle;
  final String pavilliondepth;
  final String pavillionangle;
  final String starfacelength;
  final String lowerhavels;  
  final String gridlethickness;
  final String culet;

  Report({
    @required this.id,
    @required this.grade,
    @required this.colour,
    @required this.weight,
    @required this.clarity,
    @required this.createdAt,
    @required this.tablepct,
    @required this.totaldepth,
    @required this.crownheight,
    @required this.crownangle,
    @required this.pavilliondepth,
    @required this.pavillionangle,
    @required this.starfacelength,
    @required this.lowerhavels,  
    @required this.gridlethickness,
    @required this.culet,    
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      grade: json['grade'] as String,
      colour: json['colour'] as String,
      weight: json['weight'] as String,
      clarity: json['clarity'] as String,
      createdAt: json['createdAt'] as String,

      tablepct: json["table_pct"].toString(),
      totaldepth: json["total_depth"].toString(),
      crownheight: json["crown_height"].toString(),
      crownangle: json["crown_angle"].toString(),
      pavilliondepth: json["pavillion_depth"].toString(),
      pavillionangle: json["pavillion_angle"].toString(),
      starfacelength: json["starface_length"].toString(),
      lowerhavels: json["lower_havels"].toString(),
      gridlethickness: json["gridle_thickness"].toString(),
      culet: json["culet"],
    );
  }
}
