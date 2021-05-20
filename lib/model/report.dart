import 'package:flutter/foundation.dart';

class Report {
  final int id;
  String grade;
  String createdAt;
  String colour;
  String weight;
  String clarity;
  String tablepct;
  String totaldepth;
  String crownheight;
  String crownangle;
  String pavilliondepth;
  String pavillionangle;
  String starfacelength;
  String lowerhavels;  
  String gridlethickness;
  String culet;
  int type;
  String gianumber;
  

  Report({
     this.id,
     this.grade,
     this.colour,
     this.weight,
     this.clarity,
     this.createdAt,
     this.tablepct,
     this.totaldepth,
     this.crownheight,
     this.crownangle,
     this.pavilliondepth,
     this.pavillionangle,
     this.starfacelength,
     this.lowerhavels,  
     this.gridlethickness,
     this.culet,  
     this.type,
     this.gianumber,
  
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      grade: json['grade'],
      colour: json['colour'].toString(),
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
      gianumber: json["gianumber"].toString(),
      type: json["type"],
    );
  }
}
