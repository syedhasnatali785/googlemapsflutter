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
  String stAd = 'Error Finding Adress';

  Future<void> getAddFrLtLng() async {
    try {
      List<Location> locations = await locationFromAddress(
        "XMW4+39R Satellite Town Jhelum, Pakistan",
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        32.995239,
        73.655905,
      );

      setState(() {
        address =
            "${locations.last.longitude} ${locations.last.latitude}";
        stAd = placemarks.reversed.last.country.toString() + " ";
      });
    } catch (e) {
      return print('Errrrr');
    }
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
            onTap: ()
            {
       getAddFrLtLng();
            },
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
