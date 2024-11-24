import 'package:ambulance_app/model/disability.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String baseUrl = "assets/icons/disabilities/";

final disabilityProvider = Provider((ref) => [
      Disability(id: 0, name: "MOBILITY", iconUrl: "${baseUrl}mobility.png"),
      Disability(id: 1, name: "BLINDNESS", iconUrl: "${baseUrl}eye.png"),
      Disability(id: 2, name: "LOW_VISION", iconUrl: "${baseUrl}low-vision.png"),
      Disability(id: 3, name: "DEAFNESS", iconUrl: "${baseUrl}hearing.png"),
      // Disability(id: 5, name: "HARD_HEARING", iconUrl: "${baseUrl}hearing"),
]);