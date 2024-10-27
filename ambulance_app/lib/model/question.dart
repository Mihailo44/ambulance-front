enum TraumaType{
  FALL,
	CAR_ACCIDENT,
	HEART_ATTACK,
	FIRE,
	ALCOHOL_INEBRIATION,
	POISONING,
	FALLING_OBJECT,
	ELECTROCUTION,
	ANIMAL_BITE,
	DRUG_OVERDOSE,
	CHEMICAL_EXPOSURE,
	GUNSHOT,
  OTHER
}

class Question {
  final int id;
  final TraumaType traumaType;
  final String body;
  final List<String> availableAnswers;

  const Question({
    required this.id,
    required this.traumaType,
    required this.body,
    required this.availableAnswers
  });

}