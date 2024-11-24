export 'mobile/auth_service_mobile.dart'
    if (dart.library.html) 'web/auth_service_web.dart'
    if (dart.library.io) 'mobile/auth_service_mobile.dart';
