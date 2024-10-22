// lib/services/auth_service.dart
export 'auth_service_mobile.dart'
    if (dart.library.html) 'auth_service_web.dart'
    if (dart.library.io) 'auth_service_mobile.dart';
