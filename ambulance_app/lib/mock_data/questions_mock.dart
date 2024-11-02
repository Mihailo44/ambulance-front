import 'package:ambulance_app/model/question.dart';

 class QuestionsMock {
static List<Question> questions = [
  const Question(
    id: 1,
    traumaType: TraumaType.	ALCOHOL_INEBRIATION,
    body: "Is the patient conscious?",
    availableAnswers: ["Yes", "No"]
  ),
  const Question(
    id: 2,
    traumaType: TraumaType.	ALCOHOL_INEBRIATION,
    body: "How long have you been feeling unwell?",
    availableAnswers: ["Less than a day", "1-3 days", "4-7 days", "More than a week"]
  ),
  const Question(
    id: 3,
    traumaType: TraumaType.	ALCOHOL_INEBRIATION,
    body: "Have you recently been in contact with anyone who is sick?",
    availableAnswers: ["Yes", "No", "Not Sure"]
  ),
  const Question(
    id: 4,
    traumaType: TraumaType.	ALCOHOL_INEBRIATION,
    body: "Do you have any known allergies?",
    availableAnswers: ["Yes", "No"]
  ),
  const Question(
    id: 5,
    traumaType: TraumaType.	ALCOHOL_INEBRIATION,
    body: "Are you currently taking any medications?",
    availableAnswers: ["Yes", "No", "Occasionally"]
  ),
];

}