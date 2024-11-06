import 'dart:async';

import 'package:ambulance_app/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Timer? _timer;
  final MapService mapService = MapService();
  String? addy;
  LatLng? _center;
  final Completer<GoogleMapController> _controller = Completer();
  final String _mapStyleString = '''
  [
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
    {
        "color": "#7ae4ff"
    }
    ]
  }
  ]
  ''';

  @override
  void initState(){
    super.initState();
    _getLocation();
    _timer = Timer.periodic(const Duration(seconds: 69000), (timer) {
      _getLocation();
    });
  }

  // void initMapStyle() async{
  //   _mapStyleString = await rootBundle.loadString('assets/map_style.json');
  // }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    addy = await mapService.getAddress(lat: locationData.latitude!,lon: locationData.longitude!); 
    setState(() {
     _center = LatLng(locationData.latitude!,locationData.longitude!); 
    });

    //TODO novi objekat koji ima adresu i lon i lat
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
      _controller.complete(controller);
      _controller.future.then((value) {
        value.setMapStyle(_mapStyleString);
      });
    },
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
      target: _center ?? const LatLng(45.257828,19.8196241),
      zoom: 17,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("me"),
          position: _center ?? const LatLng(45.257828,19.8196241),
        ),
      },
    );
  }
}
