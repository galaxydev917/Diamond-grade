import 'package:flutter/material.dart';
import 'package:sorts_app/screens/manualSearch.dart';

class ManualSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Calculation'),
      ),
      body: new ListView(children: [
        ManualSearchForm(),
      ],),

      

    );
  }
}