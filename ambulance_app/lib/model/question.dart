enum TraumaType{
	CAR_ACCIDENT,
	CHEST_PAIN,
  I_DONT_KNOW,
  //UNCONSCIOUSNESS,
  FALL,
	ALCOHOL_INEBRIATION,
	FALLING_OBJECT,
	FIRE,
	POISONING,
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