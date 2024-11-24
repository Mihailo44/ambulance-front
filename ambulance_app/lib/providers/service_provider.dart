import 'package:ambulance_app/services/auth_service.dart';
import 'package:ambulance_app/services/mobile/patient_service_mobile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService(container: ref.container));
final patientServiceProvider = Provider((ref) => PatientService(container: ref.container));
