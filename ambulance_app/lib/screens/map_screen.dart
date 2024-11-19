import 'dart:async';

import 'package:ambulance_app/providers/location_provider.dart';
import 'package:ambulance_app/services/map_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  Timer? _timer;
  final MapService mapService = MapService();
  bool serviceEnabled = false;
  PermissionStatus permissionGranted = PermissionStatus.denied;
  String? _address;
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
  void initState() {
    super.initState();
    _requestPermissions();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
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

    try{
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

    }on PlatformException catch(e){
      print(e);
      _requestPermissions();
    }catch(e){
      print(e);
    }

  }

  void _getLocation() async {
    Location location = Location();
    LocationData locationData;

    locationData = await location.getLocation();
    _address = await mapService.getAddress(
        lat: locationData.latitude!, lon: locationData.longitude!);

    _center = LatLng(locationData.latitude!, locationData.longitude!);

    if(_center != null){
      ref.read(locationProvider.notifier).setCoordinates(_center!);
      moveToLocation(_center!);
    }
  }

  Future<void> moveToLocation(LatLng position) async {
  final GoogleMapController controller = await _controller.future;
  setState(() {
  controller.animateCamera(CameraUpdate.newLatLng(position));
  });
}

  @override
  Widget build(BuildContext context) {
    //return const Text("ok");
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        _controller.future.then((value) {
          value.setMapStyle(_mapStyleString);
          if(permissionGranted == PermissionStatus.granted){
            print("usao");
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
