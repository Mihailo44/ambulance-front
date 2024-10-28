
class Medication {
  String name;
  int weeklyDosage;

  Medication({
    required this.name,
    required this.weeklyDosage
  });

  factory Medication.fromJson(Map<String,dynamic> json){
    return Medication(name: json['name'], weeklyDosage: json['weekly_dosage'],);
  }

}