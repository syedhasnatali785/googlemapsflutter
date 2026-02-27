import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String? _sessionToken;
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
  setState(() {
    _isLoading = true;
  });
    String kPLACES_API_KEY = "AIzaSyDWgeOroVovcKcbJ7iz5-1WZBroiRrjf-k";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString()) ['predictions'];
      _isLoading = false;
      });
    } else {
      throw Exception('Error');
    }
  }
  bool _isLoading = true;
   double? _latd;
  double? _longt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places api')),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Search Places',
            suffixIcon: IconButton(onPressed: (){
            setState(() {
              _controller.clear();
              _placesList.clear();
              _longt = null;
              _latd = null;
            });
            }, icon: Icon(Icons.clear))
            ),
          ),
          if(_isLoading)CircularProgressIndicator(),
          if(_latd != null && _longt != null)
          Padding(padding: EdgeInsets.all(8), child: Text("LAT: $_latd LONG: $_longt"),),
          Expanded(child: ListView.builder(itemCount: _placesList.length,itemBuilder: (context, index){
            //
            return ListTile(
            title: Text(_placesList[index]['description']),onTap: ()async{
            List<Location> locations = await locationFromAddress(
              _placesList[index]['description'],  
            );
          print(locations.last.longitude);
         //awaiting setstate
        setState(() {
          _latd = locations.first.latitude;
          _longt = locations.first.longitude;
          _placesList.clear();
        });
            },
          );}))
        ],
      ),
    );
  }
}
