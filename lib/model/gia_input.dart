class GIAInput {
  String weight;
  String colour;
  String clarity;
  String starface;
  String culet;
  String depthPct;
  String crownHeight;
  String pavilionDepth;
  String pavilionAngle;
  String girdle;
  String crownAngle;
  String lowerHalf;
  String tablePct;
  int type;
  String gianumber;

  GIAInput({
    this.weight,
    this.colour,
    this.clarity,
    this.starface,
    this.culet,
    this.depthPct,
    this.crownHeight,
    this.pavilionDepth,
    this.pavilionAngle,
    this.girdle,
    this.crownAngle,
    this.lowerHalf,
    this.tablePct,
    this.type,
    this.gianumber,
  });
  // factory GIAInput.fromJson(Map<String, dynamic> json) => GIAInput(
  //   dish_id: json["dish_id"] == null? null: json["dish_id"],
  //   dish_name: json["dish_name"],
  //   dish_price: json["dish_price"],
  //   dish_image: json["dish_image"],
  //   dish_currency: json["dish_currency"],
  //   dish_calories: json["dish_calories"],
  //   dish_description: json["dish_description"],
  //   dish_availability: json["dish_availability"],
  //   dish_type: json["dish_type"],
  //   next_url: json["next_url"],
  //   addoncats: List<AddonCat>.from(json["addonCat"].map((x) => AddonCat.fromJson(x))),
  //   count: 0
  // );
  Map<String, dynamic> toJson() => {
        'weight': weight,
        'colour': colour,
        'clarity': clarity,
        'starface': starface,
        'culet': culet,
        'depth_pct': depthPct,
        'crown_height': crownHeight,
        'pavilion_depth': pavilionDepth,
        'pavilion_angle': pavilionAngle,
        'girdle': girdle,
        'crown_angle': crownAngle,
        'lower_half': lowerHalf,
        'table_pct': tablePct,
        'type': type,
        'gianumber': gianumber,
      };
}
