import 'package:flutter/material.dart';
import 'package:flutter_qrscan/models/scan_model.dart';
import 'db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = "http";

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);

      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];

    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    this.selectedType = type;

    notifyListeners();
  }

  deleteScans() async {
    await DBProvider.db.deleteScans();
    this.scans = [];

    notifyListeners();
  }

  deleteScansById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(this.selectedType);
  }
}
