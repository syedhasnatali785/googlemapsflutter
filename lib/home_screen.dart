import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.32423234, -119.9088424324),
    zoom: 14,
  );
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      GoogleMap(initialCameraPosition: _kGooglePlex),
    ]));
  }
}
