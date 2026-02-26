import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class ConvertLatlongToAddress extends StatefulWidget {
  const ConvertLatlongToAddress({super.key});

  @override
  State<ConvertLatlongToAddress> createState() =>
      _ConvertLatlongToAddressState();
}

class _ConvertLatlongToAddressState extends State<ConvertLatlongToAddress> {
  String address = "Address G";
  String stAd = '';
  Future<void> getAddFrLtLng() async {


    setState(()async {
      List<Location> locations = await locationFromAddress("XMW4+39R Satellite Town Jhelum, Pakistan");
      List<Placemark> placemarks = await placemarkFromCoordinates(32.995239, 73.655905);
      address = locations.last.longitude.toString()+" "+ locations.last.latitude.toString();
    stAd = placemarks.reversed.last.country.toString()+" ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Country: ${stAd}\n ${address}"),
          GestureDetector(
            onTap: getAddFrLtLng,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.green),
              child: Center(child: Text("CNVRT")),
            ),
          ),
        ],
      ),
    );
  }
}
