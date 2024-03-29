import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sorts_app/model/report.dart';

class DetailReport extends StatefulWidget {
  final Report report;

  DetailReport({this.report});

  @override
  DetailReportState createState() {
    return DetailReportState();
  }
}

class DetailReportState extends State<DetailReport> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          _buildHeading(),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildHeading() {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.report.grade == null ?
          Container():
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              widget.report.grade,
              textAlign: TextAlign.right,
              style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.white),
            )
          ),
          widget.report.gianumber == '' || widget.report.gianumber == 'null' ?
          Container():
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'GIA: ' + widget.report.gianumber,
              textAlign: TextAlign.right,
              style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.white60),
            )
          )          
    
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('ENTERED DETAILS'),
          ),
        ),
        Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white60),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: Text(
                  'Weight ct',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    Text(
                      double.parse(widget.report.weight).toStringAsFixed(2), 
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Colour',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    Text(
                      widget.report.colour.toString(), 
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Clarity',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    Text(
                      widget.report.clarity.toString(), 
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Table %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    Text(
                      widget.report.tablepct.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Total Depth %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[

                    Text(
                      widget.report.totaldepth,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Crown Height %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.crownheight == 'null' ?
                    Text(''):
                    Text(
                      widget.report.crownheight.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Crown Angle ˚',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.crownangle == 'null' ?
                    Text(''):
                    Text(
                      widget.report.crownangle.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Pavilion Depth %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.pavilliondepth == 'null' ?
                    Text(''):
                    Text(
                      widget.report.pavilliondepth.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Pavilion Angle ˚',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.pavillionangle == 'null' ?
                    Text(''):
                    Text(
                      widget.report.pavillionangle.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    )                    
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Gridle %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.gridlethickness == 'null' ?
                    Text(''):
                    Text(
                      widget.report.gridlethickness.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Cutlet',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.culet == 'null' ?
                    Text(''):
                    Text(
                      widget.report.culet.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
              new ListTile(
                title: Text(
                  'Lower Halves %',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                trailing: Row(
                  children: <Widget>[
                    widget.report.lowerhavels == 'null' ?
                    Text('') :
                    Text(
                      widget.report.lowerhavels.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }


}
