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
      grade: json['grade'],
      colour: json['colour'],
      weight: json['weight'].toString(),
      clarity: json['clarity'] as String,
      createdAt: json['createdAt'] as String,

      tablepct: json["table_pct"].toString(),
      totaldepth: json["depth_pct"].toString(),
      crownheight: json["crown_height"].toString(),
      crownangle: json["crown_angle"].toString(),
      pavilliondepth: json["pavilion_depth"].toString(),
      pavillionangle: json["pavilion_angle"].toString(),
      starfacelength: json["starface_length"].toString(),
      lowerhavels: json["lower_half"].toString(),
      gridlethickness: json["girdle"].toString(),
      culet: json["culet"],
    );
  }
}
