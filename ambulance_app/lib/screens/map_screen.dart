import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Timer? _timer;
  CameraOptions camera = CameraOptions(
    center: Point(coordinates: Position(19.8356594 as num, 45.242523 as num)),
    zoom: 14,
    bearing: 0,
    pitch: 0);
  MapboxMap? mapboxMap;


  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      _getLocation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    mapboxMap?.dispose();
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
    // print(locationData.longitude);
    // print(locationData.latitude);

  setState(() {
    camera = CameraOptions(
    center: Point(coordinates: Position(locationData.longitude as num, locationData.latitude as num)),
    zoom: 14,
    bearing: 0,
    pitch: 0);
  });
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      key: const ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,
      cameraOptions: camera,
      onTapListener: (listener){
        print("a");
      },
    );
  }
}
