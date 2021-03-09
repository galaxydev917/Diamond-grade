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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportScreen()),
              );
            },
          ),
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(Icons.share),
        //     ),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(Icons.star_border),
        //     ),
        //   ),
        // ],
      ),
      body:  DetailReport(report: this.report),
    );
  }

}