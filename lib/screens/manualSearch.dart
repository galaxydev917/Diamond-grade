import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sorts_app/model/input.dart';
import 'package:sorts_app/model/static.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ManualSearchForm extends StatefulWidget {
  @override
  ManualSearchFormState createState() {
    return ManualSearchFormState();
  }
}

class ManualSearchFormState extends State<ManualSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _input = Input.init();
  String validateTablepctText = '';
  String validateWeightText = '';
  String validateTotalDepth = '';
  String validateCrownHeight = '';
  String validateCrownAngle = '';
  String validatePavilionDepth = '';
  String validatePavilionAngle = '';
  String validateGridleThickness = '';
  String validateStarFaceLenght = '';
  String validateLowerHavels = '';
  String textHolder = '';
  String _colourVal = 'None';

  var staticVariable = {
    "table_pct": [
      {"min": "52.4", "max": "57.5", "result": "0", "grade": "+++EX"},
      {"min": "51.4", "max": "59.5", "result": "1", "grade": "++EX"},
      {"min": "51.4", "max": "61.5", "result": "2", "grade": "+EX"},
      {"min": "50.4", "max": "62.0", "result": "3", "grade": "EX"},
      {"min": "0", "max": "50.4", "result": "4", "grade": "VG OR LOWER"},
      {"min": "62", "max": "1000", "result": "4", "grade": "VG OR LOWER"},
    ],
    "crown_height": [
      {"min": "14.5", "max": "16.5", "result": "0", "grade": "+++EX"},
      {"min": "13.5", "max": "16.7", "result": "1", "grade": "++EX"},
      {"min": "13.0", "max": "16.9", "result": "2", "grade": "+EX"},
      {"min": "12.5", "max": "17", "result": "3", "grade": "EX"},
      {"min": "0.0", "max": "12.5", "result": "4", "grade": "VG OR LOWER"},
      {"min": "17.0", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "crown_angle": [
      {"min": "33.7", "max": "35.0", "result": "0", "grade": "+++EX"},
      {"min": "32.7", "max": "35.5", "result": "1", "grade": "++EX"},
      {"min": "32.1", "max": "36.0", "result": "2", "grade": "+EX"},
      {"min": "31.5", "max": "36.5", "result": "3", "grade": "EX"},
      {"min": "0.0", "max": "31.5", "result": "4", "grade": "VERY GOOD"},
      {"min": "36.5", "max": "1000.0", "result": "4", "grade": "VERY GOOD"}
    ],
    "lower_half": [
      {"min": "70", "max": "85", "result": "0", "grade": "+++EX"},
      {"min": "0", "max": "70.0", "result": "4", "grade": "VG OR LOWER"},
      {"min": "85", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "pavilion_depth": [
      {"min": "42.2", "max": "43.8", "result": "0", "grade": "+++EX"},
      {"min": "42.2", "max": "44.3", "result": "1", "grade": "++EX"},
      {"min": "41.8", "max": "44.8", "result": "2", "grade": "+EX"},
      {"min": "0.0", "max": "41.7", "result": "4", "grade": "VG OR LOWER"},
      {"min": "44.8", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "pavilion_angle": [
      {"min": "40.2", "max": "41.5", "result": "0", "grade": "+++EX"},
      {"min": "40.2", "max": "41.5", "result": "1", "grade": "++EX"},
      {"min": "40.3", "max": "41.7", "result": "2", "grade": "+EX"},
      {"min": "40.6", "max": "41.8", "result": "3", "grade": "EX"},
      {"min": "0.0", "max": "40.6", "result": "4", "grade": "VG OR LOWER"},
      {"min": "41.8", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "girdle": [
      {"min": "1.5", "max": "4.5", "result": "0", "grade": "+++EX"},
      {"min": "0.0", "max": "1.5", "result": "4", "grade": "VG OR LOWER"},
      {"min": "4.5", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "depth_pct": [
      {"min": "45", "max": "65", "result": "0", "grade": "+++EX"},
      {"min": "0", "max": "45", "result": "4", "grade": "VG OR LOWER"},
      {"min": "65", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ]
  };
  List gradeList = [];
  List _diamondColour = [
    'None',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M'
  ];

  String _clarityVal = 'None';
  List _diamondClarity = [
    'None',
    'FL',
    'IF',
    'VVS1',
    'VVS2',
    'VS1',
    'VS2',
    'SI1',
    'SI2',
    'I1',
    'I2'
  ];

  String _culetVal = 'None';
  List _diamondCulet = [
    'None',
    'Very Small',
    'Small',
    'Medium',
    'Slightly Large',
    'Large',
    'Very Large',
    'Extremely Large'
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        //padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              // child: Text(""),
            ),
            _buildWeightField(),
            _buildColourField(),
            _buildClarityField(),
            _buildGroupDivider(),
            _buildTablePctField(),
            _buildTotalDepthField(),
            _buildGroupDivider(),
            _buildCrownHeightField(),
            _buildCrownAngleField(),
            _buildGroupDivider(),
            _buildPavilionDepthField(),
            _buildPavilionAngleField(),
            _buildGroupDivider(),
            _buildStarFacetField(),
            _buildLowerHalvesField(),
            _buildGridleField(),
            _buildCuletField(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupDivider() {
    return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Divider(
          color: Colors.white10,
          height: 20,
          thickness: 20,
        ));
  }

  Widget _buildWeightField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text(
                "Weight(ct)",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0, top: 20.0),
                child: TextFormField(
                  // autovalidateMode: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.weight = double.parse(val);
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validateWeightText',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildColourField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.5,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Colour",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.5,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: false,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                    ),
                  ),
                  // icon: Icon(Icons.arrow_drop_down),
                  disabledHint: Text('Select Colour'),
                  dropdownColor: Colors.grey,
                  elevation: 0,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  isExpanded: true,
                  value: _colourVal,
                  //style: TextStyle(color: Colors.black, fontSize: 22.0),
                  onChanged: (value) {
                    setState(() {
                      _colourVal = value;
                    });
                  },
                  onSaved: (val) =>
                      setState(() => _input.colour = val.toString()),

                  items: _diamondColour.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        )
      ],
    );
  }

  Widget _buildClarityField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.5,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Clarity",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.5,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: false,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                    ),
                  ),
                  disabledHint: Text('Select Clarity'),
                  dropdownColor: Colors.grey,
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  isExpanded: true,
                  value: _clarityVal,
                  //style: TextStyle(color: Colors.black, fontSize: 22.0),
                  onChanged: (value) {
                    setState(() {
                      _clarityVal = value;
                    });
                  },
                  onSaved: (val) =>
                      setState(() => _input.clarity = val.toString()),

                  items: _diamondClarity.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildCuletField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.5,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Culet",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.5,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: false,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                    ),
                  ),
                  // icon: Icon(Icons.arrow_drop_down),
                  disabledHint: Text('Select Culet'),
                  dropdownColor: Colors.grey,
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  isExpanded: true,
                  value: _culetVal,
                  //style: TextStyle(color: Colors.black, fontSize: 22.0),
                  onChanged: (value) {
                    setState(() {
                      _culetVal = value;
                    });
                  },
                  onSaved: (val) =>
                      setState(() => _input.culet = val.toString()),

                  items: _diamondCulet.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildTablePctField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Table %s",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.tablePct = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateTablepctText = 'Table width cannot be empty';
                      else {
                        if (num.parse(val) < 47 || num.parse(val) > 69)
                          validateTablepctText = 'Must be between 47 and 69';
                        else
                          validateTablepctText = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 20.0),
            child: Text(
              '$validateTablepctText',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalDepthField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Total Depth %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: const EdgeInsets.only(right: 20.0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.depthPct = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateTotalDepth = 'Total Depth cannot be empty';
                      else {
                        if (num.parse(val) < 53 || num.parse(val) > 66.5)
                          validateTotalDepth = 'Must be between 53 and 66.5';
                        else
                          validateTotalDepth = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 20.0),
            child: Text(
              '$validateTotalDepth',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            ))
      ],
    );
  }

  Widget _buildCrownHeightField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Crown Height %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.crownHeight = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateCrownHeight = 'Crown height cannot be empty';
                      else {
                        if (num.parse(val) < 9 || num.parse(val) > 19.5)
                          validateCrownHeight = 'Must be between 9 and 19.5';
                        else
                          validateCrownHeight = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 20.0),
            child: Text(
              '$validateCrownHeight',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCrownAngleField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Crown Angle %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.crownAngle = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateCrownAngle = 'Crown angle cannot be empty';
                      else {
                        if (num.parse(val) < 22 || num.parse(val) > 40)
                          validateCrownAngle = 'Must be between 22 and 40';
                        else
                          validateCrownAngle = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validateCrownAngle',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
      ],
    );
  }

  Widget _buildPavilionDepthField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Pavillion Depth/Height %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.pavilionDepth = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validatePavilionDepth =
                            'Pavillion depth cannot be empty';
                      else {
                        if (num.parse(val) < 40 || num.parse(val) > 47)
                          validatePavilionDepth = 'Must be between 40 and 47';
                        else
                          validatePavilionDepth = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validatePavilionDepth',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildPavilionAngleField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Pavillion Angle *",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.pavilionAngle = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validatePavilionAngle =
                            'Pavillion angle cannot be empty';
                      else {
                        if (num.parse(val) < 38.8 || num.parse(val) > 43)
                          validatePavilionAngle = 'Must be between 38.8 and 43';
                        else
                          validatePavilionAngle = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validatePavilionAngle',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
      ],
    );
  }

  Widget _buildGridleField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Gridle Thickness",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.girdle = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateGridleThickness =
                            'Girdle thickness cannot be empty';
                      else {
                        if (num.parse(val) < 1 || num.parse(val) > 7.5)
                          validateGridleThickness = 'Must be between 1 and 7.5';
                        else
                          validateGridleThickness = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validateGridleThickness',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildLowerHalvesField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Lower Halves %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.lowerHalf = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateLowerHavels = 'Lower halves cannot be empty';
                      else {
                        if (num.parse(val) < 1 || num.parse(val) > 100)
                          validateLowerHavels = 'Must be between 1 and 100';
                        else
                          validateLowerHavels = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validateLowerHavels',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildStarFacetField() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40) * 0.8,
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Star Facet Length %",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.2,
                height: 40,
                margin: EdgeInsets.only(right: 20),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    //keyboardType: TextInputType.number,
                    filled: true,
                    fillColor: Colors.white30,
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    if (val.isEmpty) return;
                    setState(() {
                      _input.starface = double.parse(val);
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      if (val.isEmpty)
                        validateStarFaceLenght =
                            'Star facet length cannot be empty';
                      else {
                        if (num.parse(val) < 1 || num.parse(val) > 100)
                          validateStarFaceLenght = 'Must be between 1 and 100';
                        else
                          validateStarFaceLenght = '';
                      }
                    });
                  },
                ))
          ],
        ),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '$validateStarFaceLenght',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            )),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Colors.white24,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      height: 46.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: new EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
          onPressed: () {
            _submitForm();
          },
          child: Text(
            'Manual Calculate',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ), //TODO: update the button styling
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          color: Color(0xff2EA3EA)),
    );
  }

  Future<void> _submitForm() async {
    if (validateWeightText != '' ||
        validateTablepctText != '' ||
        validateTotalDepth != '' ||
        validateCrownHeight != '' ||
        validateCrownAngle != '' ||
        validatePavilionDepth != '' ||
        validatePavilionAngle != '' ||
        validateGridleThickness != '' ||
        validateStarFaceLenght != '' ||
        validateLowerHavels != '') return;


    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_input.tablePct == null ||
          _input.crownHeight == null ||
          _input.crownAngle == null ||
          _input.lowerHalf == null ||
          _input.pavilionDepth == null ||
          _input.pavilionAngle == null ||
          _input.girdle == null ||
          _input.depthPct == null) return;

      final snackbar = SnackBar(content: Text('Calculating...'));
      Scaffold.of(context).showSnackBar(snackbar);
    
      var currentValList = [
        {'key': 'table_pct', 'value': _input.tablePct},
        {'key': 'crown_height', 'value': _input.crownHeight},
        {'key': 'crown_angle', 'value': _input.crownAngle},
        {'key': 'lower_half', 'value': _input.lowerHalf},
        {'key': 'pavilion_depth', 'value': _input.pavilionDepth},
        {'key': 'pavilion_angle', 'value': _input.pavilionAngle},
        {'key': 'girdle', 'value': _input.girdle},
        {'key': 'depth_pct', 'value': _input.depthPct},
      ];

      for (var i = 0; i < currentValList.length; i++) {
        var grade = await getGrade(currentValList[i]);

        gradeList.add(grade);
      }
      gradeList..sort((a, b) => b.result.compareTo(a.result));
      await _input.submit(gradeList[0].grade);
      Scaffold.of(context).removeCurrentSnackBar();
      Navigator.pop(context);
    }
  }

  Future<dynamic> getGrade(currentVal) async {
    var itemKey = currentVal['key'];
    var itemVal = currentVal['value'];

    List<dynamic> staticValueList = staticVariable[itemKey];
    List<StaticItem> staticItemList = staticValueList
        .map((dynamic item) => StaticItem.fromJson(item))
        .toList();
    staticItemList..sort((a, b) => a.result.compareTo(b.result));

    for (var i = 0; i < staticItemList.length; i++) {
      if (itemVal >= double.parse(staticItemList[i].min) &&
          itemVal <= double.parse(staticItemList[i].max)) {
        return (staticItemList[i]);
      }
    }
  }
}
