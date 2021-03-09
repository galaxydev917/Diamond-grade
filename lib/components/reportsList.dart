import 'package:flutter/material.dart';
import 'package:sorts_app/screens/DetailReportScreen.dart';
import 'package:sorts_app/model/report.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Entry {
  Entry(this.title, [this.children = const <Report>[]]);

  final String title;
  final List<Report> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this._getReports);

  final Entry entry;
  final dynamic _getReports;

  Widget _buildTiles(dynamic root, BuildContext context) {
    if (root is Entry) {
      return ExpansionTile(
        key: PageStorageKey<String>(root.title),
        title: Text(root.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        children: root.children
            .map((report) => _buildTiles(report, context))
            .toList(),
      );
    } else {
      return ListTile(
        leading: FaIcon(FontAwesomeIcons.gem), //TODO: this will need an if to determine if its API or DB to change the icon
        title: Text(
          root.createdAt,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        ),
        subtitle: Text(
          root.giaGrade ?? '',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Row(
          children: <Widget>[
            Text(
              root.grade ?? '',
              style:
                  TextStyle(fontWeight: FontWeight.w200, color: Colors.white),
            ),
            Icon(Icons.keyboard_arrow_right), //this is the twistie
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        onTap: () {
          Navigator.push(
            //this is where the functoinality is for the open/close
            context,
            MaterialPageRoute(
                builder: (context) => DetailReportScreen(report: root)),
          ).whenComplete(() => this._getReports());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, context);
  }
}
