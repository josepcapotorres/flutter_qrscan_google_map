import 'package:flutter/material.dart';
import 'package:flutter_qrscan/providers/scan_list_provider.dart';
import 'package:flutter_qrscan/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    if (scans.isEmpty) {
      return const Center(
        child: Text("No results"),
      );
    }

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          type == "http" ? Icons.home_outlined : Icons.map_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[i].value),
        subtitle: Text(scans[i].id.toString()),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => launchURL(context, scans[i]),
      ),
    );
  }
}
