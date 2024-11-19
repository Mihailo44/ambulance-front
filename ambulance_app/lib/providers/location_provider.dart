import 'package:ambulance_app/services/map_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationStateNotifier extends StateNotifier<AsyncValue<LatLng>>{
  LocationStateNotifier():super(const AsyncValue.loading());
  final MapService mapService = MapService();

  void setCoordinates(LatLng location){
    state = AsyncValue.data(location);
  }

  Future<String> getLocation() async {

    final currentLocation = state.asData?.value;

    if(currentLocation == null) return "";

    try {
      return await mapService.getAddress(
        lat: currentLocation.latitude,
        lon: currentLocation.longitude,
      );
    } catch (e) {
      rethrow;
    }
  }

}

final locationProvider = StateNotifierProvider<LocationStateNotifier,AsyncValue<LatLng>>((ref) => LocationStateNotifier());