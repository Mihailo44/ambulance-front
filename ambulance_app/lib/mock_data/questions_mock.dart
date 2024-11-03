import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/model/quiz.dart';

class QuizMock {
  static List<Quiz> quizes = [
    const Quiz(traumaType: TraumaType.ANIMAL_BITE, questions: [
      Question(
          id: 1,
          body: "Is the patient conscious?",
          availableAnswers: ["Yes", "No"]),
      Question(
          id: 2,
          body: "How long have you been feeling unwell?",
          availableAnswers: [
            "Less than a day",
            "1-3 days",
            "4-7 days",
            "More than a week"
          ]),
      Question(
          id: 3,
          body: "Have you recently been in contact with anyone who is sick?",
          availableAnswers: ["Yes", "No", "Not Sure"]),
      Question(
          id: 4,
          body: "Do you have any known allergies?",
          availableAnswers: ["Yes", "No"]),
      Question(
          id: 5,
          body: "Are you currently taking any medications?",
          availableAnswers: ["Yes", "No", "Occasionally"]),
    ]),
  ];
}
