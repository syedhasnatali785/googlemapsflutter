import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.995921, 73.664862),
    zoom: 14,
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Marker> _marker = [];
List<Marker> _list = [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(32.995921, 73.664862),
    infoWindow: InfoWindow(title: 'My Locationsss'),
  ),
  Marker(
    markerId: MarkerId('2'),
    infoWindow: InfoWindow(title: 'Street K7'),
    position: LatLng(32.993776, 73.656678),
  ),
  Marker(
    markerId: MarkerId('3'),
    infoWindow: InfoWindow(title: 'Japan'),
    position: LatLng(36.2048, 138.2529),
  ),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    loadLocationServicesPrompt();
  }

  Future<Position> getUserCurrentLocation() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      throw Exception('Prmsn Denied');
    }
    return Geolocator.getCurrentPosition();
  }

  Completer<GoogleMapController> _controller = Completer();
  loadLocationServicesPrompt()async{
    Position position = await getUserCurrentLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        16,
      ),
    );
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId('current location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );
      ;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        loadLocationServicesPrompt();
        },
        child: Icon(Icons.location_on),
      ),
      body: GoogleMap(
        initialCameraPosition: HomeScreen._kGooglePlex,
        mapType: MapType.hybrid,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
