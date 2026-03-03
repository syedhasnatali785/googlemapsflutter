import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = [LatLng(32.995952, 73.664884)];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      if (i % 2 == 0) {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                _latlng[i],
              );
            },
            position: _latlng[i],
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://maps.gstatic.com/tactile/hotels/vacation_rentals_tip_gm2_2x.png',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Rent HOUSE"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('0.3 KM away'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("CITI HOUSING REST PLACE FOR GUESTS"),
                      ),
                    ],
                  ),
                ),
                _latlng[i],
              );
            },
            position: _latlng[i],
          ),
        );
      }
    }
  }

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(32.995952, 73.664884),
              zoom: 15,
            ),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (move) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),

          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
