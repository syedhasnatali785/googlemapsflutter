import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
 final Completer<GoogleMapController> _completer = Completer();
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(32.9965, 73.6535),
    zoom: 15,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.red,
        geodesic: true,
        strokeColor: Colors.red,
        strokeWidth: 4,
      ),
    );
  }

  final Set<Marker> _markers = {};
  Set<Polygon> _polygon = {};
  List<LatLng> points = [
    LatLng(33.001325, 73.652540),
    LatLng(32.986641, 73.658845),
    LatLng(32.993361, 73.647921),
    LatLng(32.998502, 73.649802),
    LatLng(33.000080, 73.654688),
    LatLng(33.001325, 73.652540),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
