import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qrscan/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)?.settings.arguments as ScanModel?;

    if (scan == null) {
      return const Center(child: Text("No se ha encontrado la url"));
    }

    final initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50,
    );

    // Markers
    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId("geo-location"),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_disabled),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17.5,
                    tilt: 50,
                  ),
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
        child: const Icon(Icons.layers),
        onPressed: () {
          if (_mapType == MapType.normal) {
            _mapType = MapType.satellite;
          } else {
            _mapType = MapType.normal;
          }

          setState(() {});
        },
      ),
    );
  }
}
