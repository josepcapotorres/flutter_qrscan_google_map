import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qrscan/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50,
    );

    // Markers
    Set<Marker> markers = new Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId("geo-location"), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getLatLng(), zoom: 17.5, tilt: 50),
                ),
              );
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: _mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (_mapType == MapType.normal) {
            _mapType = MapType.satellite;
          }else{
            _mapType = MapType.normal;
          }

          setState(() {
            
          });
        },
      ),
    );
  }
}
