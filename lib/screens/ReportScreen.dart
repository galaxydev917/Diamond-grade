import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorts_app/screens/manualSearchScreen.dart';
import '../model/report.dart';
import 'package:sorts_app/service/Database.dart';
import 'package:sorts_app/screens/DetailReportScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sorts_app/model/gia_input.dart';

class ReportScreen extends StatefulWidget {
  @override
  createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  final _input = GIAInput();

  // ignore: deprecated_member_use
  var reports = new List<Report>();
  String code = "";

  // ignore: non_constant_identifier_names
  String report_number = '';
  bool isViewGIA = false;
  bool isEnableAddGia = false;
  bool isLoadingReports = false;

  final String _query = r'''
    query ReportQuery($reportNumber: String!) {
      getReport(report_number: $reportNumber){
        report_date
        report_number
        report_type
        results {
          ... on DiamondGradingReportResults {
            measurements
            shape_and_cutting_style
            carat_weight
            color_grade
            clarity_grade
            cut_grade
            report_comments
            proportions {
              table_pct
              depth_pct
              crown_height
              crown_angle
              pavilion_depth
              pavilion_angle
              girdle
              culet
              lower_half
            }
          data {
            polish
            symmetry
            fluorescence {
              fluorescence_intensity
              fluorescence_color
            }
            inscription_graphics {
              description
              image
            }
          }
        }
      }
      quota {
        remaining
          }
      
      links {
        pdf
        proportions_diagram
        plotting_diagram
      }
    }
  }
''';
  @override
  void initState() {
    _getReports();
    //FlutterMobileVision.start().then((value) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Recent Review'),
      ),
      body: _buildReportsList(),
      floatingActionButton: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width - 20,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ManualSearchScreen()),
            ).whenComplete(() => _getReports());
          },
          tooltip: "Calculate a diamond grade manually using the form",
          label: Text(
            "Manual Calculation",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          backgroundColor: Color(0xff2EA3EA),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _getReports() {
    setState(() {
      isLoadingReports = true;
    });
    DBProvider.db.getAllReports().then((value) => {
          setState(() {
            reports = value;
            isViewGIA = false;
            isLoadingReports = false;
            print(reports);
          })
        });
  }

  _getGIAReport() {
    if (report_number == '') return;

    isEnableAddGia = true;
    setState(() {
      isViewGIA = true;
    });
  }

  addReportToSql(result) async {
    // if (gia_result == null) {
    //   setState(() {
    //     isViewGIA = false;
    //   });
    //   return;
    // }
    // print(report_number);
    // var result = gia_result['getReport'];
    // if (result == null) {
    //   setState(() {
    //     isViewGIA = false;
    //   });
    //   return;
    // }

    isEnableAddGia = false;
    _input.weight = result['results']['carat_weight'];
    _input.clarity = result['results']['clarity_grade'];
    _input.colour = result['results']['color_grade'];
    _input.crownAngle = result['results']['proportions']['crown_angle'];
    _input.crownHeight = result['results']['proportions']['crown_height'];
    _input.culet = result['results']['proportions']['culet'];
    _input.depthPct = result['results']['proportions']['depth_pct'];
    _input.girdle = result['results']['proportions']['girdle'];
    _input.lowerHalf = result['results']['proportions']['lower_half'];
    _input.pavilionAngle = result['results']['proportions']['pavilion_angle'];
    _input.pavilionDepth = result['results']['proportions']['pavilion_depth'];
    _input.starface = '';
    _input.tablePct = result['results']['proportions']['table_pct'];
    _input.type = 1;
    _input.gianumber = report_number;
    print(_input.toJson());
    await DBProvider.db.addGIAReport(_input.toJson());
    _getReports();
  }

  Widget _buildReportsList() {
    return isLoadingReports
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: (MediaQuery.of(context).size.width) * 0.7,
                          height: 60,
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          //margin: const EdgeInsets.only(left: 10.0, right:10.0, top:20.0),
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              //keyboardType: TextInputType.number,
                              filled: true,
                              fillColor: Colors.white30,
                              contentPadding: EdgeInsets.all(0.0),
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
                              hintText: "Enter a GIA Number",
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (val) {
                              //report_number = "2141438171";
                              report_number = val;
                            },
                          )),
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.3,
                        height: 50,
                        padding: EdgeInsets.only(right: 10.0, top: 5.0),
                        child: ElevatedButton(
                            child: Text('GIA Look Up'),
                            onPressed: () {
                              _getGIAReport();
                            }),
                      )
                    ],
                  ),
                ),
                isViewGIA == true
                    ? Query(
                        options: QueryOptions(
                            documentNode: gql(_query),
                            variables: {'reportNumber': report_number}),
                        builder: (
                          QueryResult result, {
                          VoidCallback refetch,
                          FetchMore fetchMore,
                        }) {
                          if (result.loading) {
                            return Container(
                                child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                  Text(
                                    "Loading...",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ));
                          }
                          // if (result.hasException) return Container();
                          if (result.hasException || result.data == null || result.data['getReport'] == null) {
                            if (reports.length > 0)
                              return Container(
                                  height: (MediaQuery.of(context).size.height -
                                      220),
                                  margin: EdgeInsets.all(10.0),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: Colors.white24,
                                    ),
                                    itemCount: reports.length,
                                    itemBuilder: (context, index) =>
                                        _buildReportItem(reports[index]),
                                  ));
                            else
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 50.0),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          "assets/images/binoculars.png",
                                          width: 150,
                                          height: 150),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "Find a stone!",
                                        style: TextStyle(
                                            letterSpacing: 5.0,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 40.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Search for a stone and it will show up here.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            letterSpacing: 1.5,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              );
                          } else {
                            if (isEnableAddGia)
                              addReportToSql(result.data['getReport']);

                            return Container(
                                height:
                                    (MediaQuery.of(context).size.height - 170),
                                margin: EdgeInsets.all(10.0),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.white24,
                                  ),
                                  itemCount: reports.length,
                                  itemBuilder: (context, index) =>
                                      _buildReportItem(reports[index]),
                                ));
                          }
                        },
                      )
                    : reports.length > 0
                        ? Container(
                            height: (MediaQuery.of(context).size.height - 220),
                            margin: EdgeInsets.all(10.0),
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.white24,
                              ),
                              itemCount: reports.length,
                              itemBuilder: (context, index) =>
                                  _buildReportItem(reports[index]),
                            ))
                        : Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 50.0),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                      "assets/images/binoculars.png",
                                      width: 150,
                                      height: 150),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    "Find a stone!",
                                    style: TextStyle(
                                        letterSpacing: 5.0,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 40.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Search for a stone and it will show up here.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
              ],
            ),
          ));
  }

  Widget _buildReportItem(report) {
    return ListTile(
      title: report.type == 1
          ? Text(
              "GIA: " + report.gianumber,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white70),
            )
          : Text(
              report.createdAt,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white70),
            ),
      subtitle: _buildSubTitle(report),
      trailing: Row(
        children: <Widget>[
          Text(
            report.grade ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white60),
          ),
          Icon(Icons.keyboard_arrow_right,
              color: Colors.white70), //this is the twistie
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: () {
        Navigator.pushReplacement(
          //this is where the functoinality is for the open/close
          context,
          MaterialPageRoute(
              builder: (context) => DetailReportScreen(report: report)),
        );
      },
    );
  }

  Widget _buildSubTitle(report) {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              report.colour ?? '',
              style: TextStyle(fontSize: 14),
            )),
        Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              report.weight + 'ct' ?? '',
              style: TextStyle(fontSize: 14),
            )),
        Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              report.clarity ?? '',
              style: TextStyle(fontSize: 14),
            ))
      ],
    );
  }
}
