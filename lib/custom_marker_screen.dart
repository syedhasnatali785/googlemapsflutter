import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _LatLng = <LatLng>[
    LatLng(12.4324, -145.43535),
    LatLng(34.65654, -54.243453),
  ];
  List<String> images = ['assets/icon/bycicle.png', 'assets/icon/car.png'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    loadCustomMarker();
  }

  void loadData()async {
    for (int i = 0; i < _LatLng.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _LatLng[i],
          infoWindow: InfoWindow(title: 'Location: ' + i.toString()),
          icon: BitmapDescriptor.bytes(markerIcon)
        ),

      );

    }
    setState(() {

    });
  }
void loadCustomMarker()async{
customImage = await BitmapDescriptor.asset(ImageConfiguration(size: Size(48,40)), 'assets/icon/car.png');
setState(() {

});
  }
  BitmapDescriptor? customImage;
Uint8List? markerImage;
  Future<Uint8List> getBytesFromAssets (String path, int width)async{
  ByteData data = await rootBundle.load(path);
 ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
 ui.FrameInfo frameInfo = await codec.getNextFrame();
 return   (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(12.5454, -12.3543),
          zoom: 12,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
