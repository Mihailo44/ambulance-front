class Medication {
  String name;
  int weeklyDosage;

  Medication({required this.name, required this.weeklyDosage});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? 'Not specified',
      weeklyDosage: json['weekly_dosage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "weekly_dosage": weeklyDosage};
  }
}
