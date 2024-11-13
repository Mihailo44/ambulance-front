
import 'package:ambulance_app/util/dateFormater.dart';

class AmbulanceRequest {
  final DateTime createdAt;

  AmbulanceRequest({
    required this.createdAt
  });

  String get formatedCreationTimestamp {
    return formatter.format(createdAt);
  }
}