import 'package:ambulance_app/model/medication.dart';

class Disease {
  String name;
  List<Medication> medications;

  Disease({
    required this.name,
    required this.medications,
  });
<<<<<<< HEAD

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name'],
      medications: json['medications'] == null
          ? []
          : (json['medications'] as List)
              .map((e) => Medication.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "medications":
          medications.map((medication) => medication.toJson()).toList()
    };
  }
}
=======
}
>>>>>>> main
