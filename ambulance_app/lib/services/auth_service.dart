<<<<<<< HEAD
export 'mobile/auth_service_mobile.dart'
=======
export 'web/auth_service_web.dart'
>>>>>>> main
    if (dart.library.html) 'web/auth_service_web.dart'
    if (dart.library.io) 'mobile/auth_service_mobile.dart';
