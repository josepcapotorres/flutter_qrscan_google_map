import 'package:flutter/material.dart';
import 'package:flutter_qrscan/pages/addresses_page.dart';
import 'package:flutter_qrscan/providers/scan_list_provider.dart';
import 'package:flutter_qrscan/providers/ui_provider.dart';
import 'package:flutter_qrscan/widgets/custom_navigatorbar.dart';
import 'package:flutter_qrscan/widgets/scan_button.dart';
import 'package:provider/provider.dart';

import 'maps_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Record"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteScans();
            },
          ),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (uiProvider.selectedMenuOpt) {
      case 0:
        scanListProvider.loadScansByType("geo");
        return const MapsPage();
      case 1:
        scanListProvider.loadScansByType("http");
        return const AddressesPage();
      default:
        scanListProvider.loadScansByType("geo");
        return const MapsPage();
    }
  }
}
