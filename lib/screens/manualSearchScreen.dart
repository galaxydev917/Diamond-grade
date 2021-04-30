import 'package:flutter/material.dart';
import 'package:sorts_app/screens/manualSearch.dart';
import 'package:sorts_app/screens/ReportScreen.dart';

class ManualSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Calculation'),
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
      body: new ListView(children: [
        ManualSearchForm(),
      ],),

      

    );
  }
}