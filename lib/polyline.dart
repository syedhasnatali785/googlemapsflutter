import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polyline_screen extends StatefulWidget {
  const Polyline_screen({super.key});

  @override
  State<Polyline_screen> createState() => _Polyline_screenState();
}

class _Polyline_screenState extends State<Polyline_screen> {
  Completer<GoogleMapController> _completer = Completer();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(32.992055, 73.660427),
    zoom: 15,
  );
  final Set<Marker> _marker = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> points = [
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
    for (int i = 0; i < points.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: points[i],
          infoWindow: InfoWindow(
            title: "Location" + i.toString(),
            snippet: "5 star rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
    _polylines.add(
      Polyline(
        polylineId: PolylineId('e3'),
        points: points,
        color: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: (cameraPosition),
        mapType: MapType.normal,

        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        markers: _marker,
        polylines: _polylines,
      ),
    );
  }
}
