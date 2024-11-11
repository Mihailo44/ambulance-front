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
  bool serviceEnabled = false;
  PermissionStatus permissionGranted = PermissionStatus.granted;
  String? _address;
  LatLng? _center;
  Completer<GoogleMapController> _controller = Completer();
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
  void initState() {
    super.initState();
    _requestPermissions();
    _timer = Timer.periodic(const Duration(seconds: 69000), (timer) {
      _getLocation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _requestPermissions() async {
    Location location = Location();

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
  }

  void _getLocation() async {
    Location location = Location();
    LocationData locationData;

    locationData = await location.getLocation();
    _address = await mapService.getAddress(
        lat: locationData.latitude!, lon: locationData.longitude!);

    setState(() {
      _center = LatLng(locationData.latitude!, locationData.longitude!);
    });

    moveToLocation(_center!);
  }

  Future<void> moveToLocation(LatLng position) async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newLatLng(position));
}

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        _controller.future.then((value) {
          value.setMapStyle(_mapStyleString);
          if(permissionGranted == PermissionStatus.granted){
            _getLocation();
          }
        });
      },
      initialCameraPosition: CameraPosition(
        target: _center ?? const LatLng(45.257828, 19.8196241),
        zoom: 17,
      ),
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      markers: _center != null
          ? {
              Marker(
                markerId: const MarkerId("me"),
                infoWindow: InfoWindow(title: "You", snippet: _address),
                position: _center!,
              ),
            }
          : {},
    );
  }
}
