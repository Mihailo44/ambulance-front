import 'package:ambulance_app/model/operating_base.dart';
import 'package:ambulance_app/model/users/user.dart';

class Dispatcher {
  int? id;
  int userId;
  User user;
  int operatingBaseId;
  OperatingBase operatingBase;

  Dispatcher({
    this.id,
    required this.userId,
    required this.user,
    required this.operatingBaseId,
    required this.operatingBase,
  });
}