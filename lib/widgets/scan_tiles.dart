import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_qrscan/providers/scan_list_provider.dart';
import 'package:flutter_qrscan/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  ScanTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    if (scans.isEmpty) {
      return Center(
        child: Text("No results"),
      );
    }

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          this.type == "http" ? Icons.home_outlined : Icons.map_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[i].value),
        subtitle: Text(scans[i].id.toString()),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => launchURL(context, scans[i]),
      ),
    );
  }
}
