import 'package:flutter/material.dart';
import 'package:sorts_app/components/DetailReport.dart';
import 'package:sorts_app/model/report.dart';
import 'package:sorts_app/screens/ReportScreen.dart';

class DetailReportScreen extends StatelessWidget {
  DetailReportScreen({Key key, this.report }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorts Grade'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ReportScreen()),
              );
            },
          ),
      ),
      body:  DetailReport(report: this.report),
    );
  }

}