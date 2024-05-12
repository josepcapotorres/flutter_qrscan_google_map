import 'package:flutter/material.dart';
import 'package:flutter_qrscan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.value;

  if (scan.type == "http") {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  } else {
    Navigator.pushNamed(context, "map", arguments: scan);
  }
}
