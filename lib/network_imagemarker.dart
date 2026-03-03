import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImagemarker extends StatefulWidget {
  const NetworkImagemarker({super.key});

  @override
  State<NetworkImagemarker> createState() => _NetworkImagemarkerState();
}

class _NetworkImagemarkerState extends State<NetworkImagemarker> {
  final List<Marker> _marker = [];
  List<LatLng> _latlng = [
    LatLng(33.001325, 73.652540),
    LatLng(32.986641, 73.658845),
    LatLng(32.993361, 73.647921),
    LatLng(32.998502, 73.649802),
    LatLng(33.000080, 73.654688),
    LatLng(33.001325, 73.652540),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _marker.add(
        Marker(markerId: MarkerId(i.toString()), position: _latlng[i], ),
      );
    }
    setState(() {});
  }

  final Completer<GoogleMapController> _completer = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(33.001325, 73.652540),
          zoom: 15,
        ),
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
