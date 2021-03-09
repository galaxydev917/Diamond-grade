
import 'package:flutter/material.dart';
import 'package:sorts_app/screens/manualSearchScreen.dart';
import '../model/report.dart';
import 'package:sorts_app/service/Database.dart';

class ReportScreen extends StatefulWidget {
  @override
  createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  var reports = new List<Report>();
  String code = "";

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
            Navigator.push(
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
          setState(() {
            reports = value;
          })
        });
  }

  Widget _buildReportsList() {
    if (reports.length > 0) {
      return Container(
          height: 700,
          margin: EdgeInsets.all(10.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.white24,
            ),
            itemCount: reports.length,
            itemBuilder: (context, index) => _buildReportItem(reports[index]),
          ));
    } else {
      return Container(
        child: Column(
          children: <Widget>[
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
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
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
    }
  }

  Widget _buildReportItem(report) {
    return ListTile(
      title: Text(
        report.createdAt,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white70),
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
