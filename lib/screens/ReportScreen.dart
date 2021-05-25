import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorts_app/screens/manualSearchScreen.dart';
import '../model/report.dart';
import 'package:sorts_app/service/Database.dart';
import 'package:sorts_app/screens/DetailReportScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sorts_app/model/gia_input.dart';
import 'package:sorts_app/model/static.dart';
import '../service/graphqlConf.dart';

class ReportScreen extends StatefulWidget {
  @override
  createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  var staticVariable = {
    "table_pct": [
      {"min": "52.4", "max": "57.5", "result": "0", "grade": "Excellent +++"},
      {"min": "51.4", "max": "59.5", "result": "1", "grade": "Excellent ++"},
      {"min": "51.4", "max": "61.5", "result": "2", "grade": "Excellent +"},
      {"min": "50.4", "max": "62.0", "result": "3", "grade": "Excellent"},
      {"min": "0", "max": "50.4", "result": "4", "grade": "VG OR LOWER"},
      {"min": "62", "max": "1000", "result": "4", "grade": "VG OR LOWER"},
    ],
    "crown_height": [
      {"min": "14.5", "max": "16.5", "result": "0", "grade": "Excellent +++"},
      {"min": "13.5", "max": "16.7", "result": "1", "grade": "Excellent ++"},
      {"min": "13.0", "max": "16.9", "result": "2", "grade": "Excellent +"},
      {"min": "12.5", "max": "17", "result": "3", "grade": "Excellent"},
      {"min": "0.0", "max": "12.5", "result": "4", "grade": "VG OR LOWER"},
      {"min": "17.0", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "crown_angle": [
      {"min": "33.7", "max": "35.0", "result": "0", "grade": "Excellent +++"},
      {"min": "32.7", "max": "35.5", "result": "1", "grade": "Excellent ++"},
      {"min": "32.1", "max": "36.0", "result": "2", "grade": "Excellent +"},
      {"min": "31.5", "max": "36.5", "result": "3", "grade": "Excellent"},
      {"min": "0.0", "max": "31.5", "result": "4", "grade": "VERY GOOD"},
      {"min": "36.5", "max": "1000.0", "result": "4", "grade": "VERY GOOD"}
    ],
    "lower_half": [
      {"min": "70", "max": "85", "result": "0", "grade": "Excellent +++"},
      {"min": "0", "max": "70.0", "result": "4", "grade": "VG OR LOWER"},
      {"min": "85", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "pavilion_depth": [
      {"min": "42.2", "max": "43.8", "result": "0", "grade": "Excellent +++"},
      {"min": "42.2", "max": "44.3", "result": "1", "grade": "Excellent ++"},
      {"min": "41.8", "max": "44.8", "result": "2", "grade": "Excellent +"},
      {"min": "0.0", "max": "41.7", "result": "4", "grade": "VG OR LOWER"},
      {"min": "44.8", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "pavilion_angle": [
      {"min": "40.2", "max": "41.5", "result": "0", "grade": "Excellent +++"},
      {"min": "40.2", "max": "41.5", "result": "1", "grade": "Excellent ++"},
      {"min": "40.3", "max": "41.7", "result": "2", "grade": "Excellent +"},
      {"min": "40.6", "max": "41.8", "result": "3", "grade": "Excellent"},
      {"min": "0.0", "max": "40.6", "result": "4", "grade": "VG OR LOWER"},
      {"min": "41.8", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "girdle": [
      {"min": "1.5", "max": "4.5", "result": "0", "grade": "Excellent +++"},
      {"min": "0.0", "max": "1.5", "result": "4", "grade": "VG OR LOWER"},
      {"min": "4.5", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ],
    "depth_pct": [
      {"min": "45", "max": "65", "result": "0", "grade": "Excellent +++"},
      {"min": "0", "max": "45", "result": "4", "grade": "VG OR LOWER"},
      {"min": "65", "max": "1000.0", "result": "4", "grade": "VG OR LOWER"}
    ]
  };
  List gradeList = [];

  final _input = GIAInput();
  final detailReport = Report();
  // ignore: deprecated_member_use
  var reports = new List<Report>();
  // ignore: deprecated_member_use
  var reportByNumber = new Report();
  bool isLoadingGia = false;
  String code = "";
  String validateGiaText = "";
  // ignore: non_constant_identifier_names
  String report_number = '';
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
    //FlutterMobileVision.start().then((value) => setState(() {}));
    super.initState();
    _getReports();
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
    DBProvider.db.getAllReports().then((value) => {
          if (this.mounted)
            {
              setState(() {
                reports = value;
              })
            }
        });
  }

  _getGIAReport() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result;

    if (report_number == '' || report_number.length != 10) {
      setState(() {
        validateGiaText =
            "Invalid GIA number. Please check the number and try again.";
      });
      return;
    }

    DBProvider.db.getReportByNumber(report_number).then((value) async => {
          // ignore: sdk_version_ui_as_code
          if (value.length > 0)
            {
              reportByNumber = value[0],
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailReportScreen(report: reportByNumber)),
              ),
            }
          else
            {
              setState(() {
                isLoadingGia = true;
              }),
              result = await _client.query(
                QueryOptions(
                    documentNode: gql(_query),
                    variables: {'reportNumber': report_number}),
              ),
              if (result.hasException)
                {
                  setState(() {
                    validateGiaText =
                        "GIA Report not found. Please check the number and try again.";
                    isLoadingGia = false;
                  }),
                }
              else if (result.data == null || result.data['getReport'] == null)
                {
                  setState(() {
                    validateGiaText =
                        "GIA Report not found. Please check the number and try again.";
                    isLoadingGia = false;
                  }),
                }
              else if (result.data['getReport']['results']
                      ['shape_and_cutting_style'] !=
                  'Round Brilliant')
                {
                  setState(() {
                    validateGiaText =
                        "GIA Report not found. Please check the number and try again.";
                    isLoadingGia = false;
                  }),
                }
              else
                addReportToSql(result.data['getReport'])
            }
        });
  }

  addReportToSql(result) async {
    var weightRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

    _input.weight = result['results']['carat_weight'];
    var weight = weightRE
        .allMatches(_input.weight)
        .map((m) => double.parse(m[0]))
        .toList();

    _input.weight = weight[0].toString();
    detailReport.weight = _input.weight;

    _input.clarity = result['results']['clarity_grade'];
    detailReport.clarity = _input.clarity;

    _input.colour = result['results']['color_grade'];
    detailReport.colour = _input.colour;

    _input.crownAngle = result['results']['proportions']['crown_angle'];
    detailReport.crownangle = _input.crownAngle;

    _input.crownHeight = result['results']['proportions']['crown_height'];
    detailReport.crownheight = _input.crownHeight;

    _input.culet = result['results']['proportions']['culet'];
    detailReport.culet = _input.culet;

    _input.depthPct = result['results']['proportions']['depth_pct'];
    detailReport.totaldepth = _input.depthPct;

    _input.girdle = result['results']['proportions']['girdle'];

    _input.lowerHalf = result['results']['proportions']['lower_half'];
    detailReport.lowerhavels = _input.lowerHalf;

    _input.pavilionAngle = result['results']['proportions']['pavilion_angle'];
    detailReport.pavillionangle = _input.pavilionAngle;

    _input.pavilionDepth = result['results']['proportions']['pavilion_depth'];
    detailReport.pavilliondepth = _input.pavilionDepth;

    _input.starface = '';
    detailReport.starfacelength = '';

    _input.tablePct = result['results']['proportions']['table_pct'];
    detailReport.tablepct = _input.tablePct;

    _input.type = 1;
    detailReport.type = _input.type;

    _input.gianumber = report_number;
    detailReport.gianumber = _input.gianumber;

    var doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
    var girdleNumbers = doubleRE
        .allMatches(_input.girdle)
        .map((m) => double.parse(m[0]))
        .toList();

    var currentValList = [
      {'key': 'table_pct', 'value': double.parse(_input.tablePct)},
      {'key': 'crown_height', 'value': double.parse(_input.crownHeight)},
      {'key': 'crown_angle', 'value': double.parse(_input.crownAngle)},
      {'key': 'lower_half', 'value': double.parse(_input.lowerHalf)},
      {'key': 'pavilion_depth', 'value': double.parse(_input.pavilionDepth)},
      {'key': 'pavilion_angle', 'value': double.parse(_input.pavilionAngle)},
      {'key': 'girdle', 'value': girdleNumbers[0]},
      {'key': 'depth_pct', 'value': double.parse(_input.depthPct)},
    ];

    for (var i = 0; i < currentValList.length; i++) {
      var grade = await getGrade(currentValList[i]);

      gradeList.add(grade);
    }
    gradeList..sort((a, b) => b.result.compareTo(a.result));

    _input.girdle = girdleNumbers[0].toString();
    detailReport.gridlethickness = _input.girdle;

    _input.grade = gradeList[0].grade;
    detailReport.grade = _input.grade;

    await DBProvider.db.addGIAReport(_input.toJson());
    setState(() {
      isLoadingGia = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DetailReportScreen(report: detailReport)),
    );
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

  Widget _buildReportsList() {
    return SingleChildScrollView(
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
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    //margin: const EdgeInsets.only(left: 10.0, right:10.0, top:20.0),
                    child: Column(children: [
                      TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          setState(() {
                            if (val.length != 10) {
                              validateGiaText =
                                  'Report numner must be 10 digits';
                            } else
                              validateGiaText = '';
                          });
                          report_number = val;
                        },
                      ),
                      // ignore: sdk_version_ui_as_code
                    ])),
                Container(
                  width: (MediaQuery.of(context).size.width) * 0.3,
                  height: 50,
                  padding: EdgeInsets.only(right: 10.0, top: 5.0),
                  child: ElevatedButton(
                      child: Text('GIA Look Up'),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        _getGIAReport();
                      }),
                )
              ],
            ),
          ),
          isLoadingGia
              ? Container(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 1,
                      ),
                    ],
                  ),
                ))
              : reports.length > 0
                  ? Container(
                      //margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                '$validateGiaText',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              )),
                          Container(
                              height:
                                  (MediaQuery.of(context).size.height - 220),
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.white24,
                                ),
                                itemCount: reports.length,
                                itemBuilder: (context, index) =>
                                    _buildReportItem(reports[index]),
                              ))
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                '$validateGiaText',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 50.0),
                            alignment: Alignment.center,
                            child: Image.asset("assets/images/binoculars.png",
                                width: 150, height: 150),
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
              double.parse(report.weight).toStringAsFixed(2) + ' ct' ?? '',
              style: TextStyle(fontSize: 14),
            )),
        Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              report.colour ?? '',
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
